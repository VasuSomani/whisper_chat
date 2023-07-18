import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/colors.dart';
import '../../controllers/auth_text_fields.dart';
import '../utils/buttons.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final emailID = TextEditingController();
    final password = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool _isLoading = false;

    void authorize() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Navigator.popAndPushNamed(context, '/chat');
      }
    }

    return Scaffold(
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
                  size: 200,
                  color: primaryColor,
                ),
                Text("Login", style: Theme.of(context).textTheme.headlineLarge),
                Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 100),
                          child: TextFieldEmail(emailID),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 100),
                          child: TextFieldPass(password),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 100),
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
                                padding:
                                    EdgeInsets.symmetric(vertical: height / 30),
                                child: SizedBox(
                                  width: width,
                                  child: PrimaryButton(
                                      () => authorize(), "Log In",
                                      isLoading: _isLoading),
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
                                      "Want to whisper?  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, '/chat'),
                                      child: Text(
                                        "Stay Anonymous",
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
    );
  }
}
