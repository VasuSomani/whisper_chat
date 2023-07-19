import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper_chat/services/auth_service.dart';
import '../../Constants/colors.dart';
import '../utils/buttons.dart';
import '../../controllers/auth_textfields.dart';
import '../utils/snackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextEditingController userName = TextEditingController();
    TextEditingController emailID = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    final formKey = GlobalKey<FormState>();
    AuthService authService = AuthService();

    void authorize() async {
      if (formKey.currentState!.validate()) {
        try {
          setState(() {
            isLoading = true;
          });
          await authService
              .signUpWithUserData(
                  userName: userName.text.toString(),
                  email: emailID.text.toString(),
                  password: password.text.toString())
              .then((value) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacementNamed(context, '/chat');
            showCustomSnackBar("Account created successfully", context);
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
          child: Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height / 40),
                      child: Text(
                        "Create an Account",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height / 100),
                                child: TextFieldUserName(userName),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height / 100),
                                child: TextFieldEmail(emailID),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height / 100),
                                child: TextFieldPass(password),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height / 100),
                                child: TextFieldConfirmPass(
                                    confirmPassword, password),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 30),
                          child: SizedBox(
                            width: width,
                            child: PrimaryButton(() => authorize(), "Sign Up",
                                isLoading: isLoading),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/login'),
                              child: Text(
                                "Log In",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
