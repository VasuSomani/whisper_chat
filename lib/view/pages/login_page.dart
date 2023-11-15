import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth_service.dart';
import '../../Constants/colors.dart';
import '../../controllers/auth_textfields.dart';
import '../utils/custom_buttons.dart';
import 'anonymous_login_page.dart';
import '../utils/custom_snackbar.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isLoading = false;
  DateTime lastBackPressed = DateTime.now();
  final emailID = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    void authorize() async {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        isLoading = true;
      });
      if (emailID.text.toString().trim().isEmpty ||
          password.text.toString().trim().isEmpty) {
        setState(() {
          isLoading = false;
        });
        showCustomSnackBar("Email and Password can't be empty", context,
            isAlert: true);
        return;
      }
      try {
        await authService
            .signInWithEmail(emailID.text.toString(), password.text.toString())
            .then((value) async {
          await authService.checkEmailVerified().then((value) async {
            if (value) {
              debugPrint("Email verified");

              Navigator.pushReplacementNamed(context, '/private_room');
            } else {
              debugPrint("Email not verified");
              setState(() {
                isLoading = false;
              });
              showCustomSnackBar("Please verify your email first", context,
                  isAlert: true);
            }
            setState(() {
              isLoading = false;
            });
          });
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        showCustomSnackBar(e.message.toString(), context, isAlert: true);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          final timeDifference = DateTime.now().difference(lastBackPressed);
          lastBackPressed = DateTime.now();
          if (timeDifference >= const Duration(seconds: 2)) {
            showCustomSnackBar("Press back again to exit.", context);
            return false;
          } else {
            SystemNavigator.pop(animated: true);
            return true;
          }
        },
        child: SafeArea(
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
                  Image.asset(
                    'assets/icons/chat_icon.png',
                    color: primaryColor,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height / 30),
                  Form(
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, "/forgot_password"),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pushNamed(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Chat Secretly",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AnonymousLogin(),
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
