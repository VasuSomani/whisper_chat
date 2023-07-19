import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisper_chat/services/auth_service.dart';
import '../../Constants/colors.dart';
import '../../controllers/auth_textfields.dart';
import '../utils/buttons.dart';
import '../utils/enter_username.dart';
import '../utils/snackbar.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final emailID = TextEditingController();
    final password = TextEditingController();
    final formKey = GlobalKey<FormState>();
    AuthService authService = AuthService();

    void authorize() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        try {
          await authService
              .signInWithEmail(
                  emailID.text.toString(), password.text.toString())
              .then((value) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacementNamed(context, '/chat');
            showCustomSnackBar("Logged In successfully", context);
          });
        } on FirebaseAuthException catch (e) {
          setState(() {
            isLoading = false;
          });
          showCustomSnackBar(e.message.toString(), context, isAlert: true);
        }
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    "Whisper Chat",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: primaryColor),
                  ),
                  const Icon(
                    CupertinoIcons.chat_bubble_2,
                    size: 120,
                    color: primaryColor,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height / 30),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: TextFieldEmail(emailID),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: TextFieldPass(password),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height / 100),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height / 30),
                                  child: SizedBox(
                                    width: width,
                                    child: PrimaryButton(
                                        () => authorize(), "Log In",
                                        isLoading: isLoading),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height / 75, bottom: height / 100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.pushNamed(
                                            context, '/signup'),
                                        child: Text(
                                          "Sign Up",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height / 100, bottom: height / 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Chat Secretly  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserName(),
                                            )),
                                        child: Text(
                                          "Login Anonymously",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
