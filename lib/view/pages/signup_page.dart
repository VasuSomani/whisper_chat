import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../utils/buttons.dart';
import '../../controllers/auth_text_fields.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final name = TextEditingController();
    final emailID = TextEditingController();
    final password = TextEditingController();
    final confirmPassword = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void _authorize() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Navigator.pushReplacementNamed(context, '/chat');
      }
    }

    return Scaffold(
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
                              padding:
                                  EdgeInsets.symmetric(vertical: height / 100),
                              child: TextFieldName(name),
                            ),
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
                          child: PrimaryButton(() => _authorize(), "Sign Up",
                              isLoading: _isLoading),
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
                            onTap: () => Navigator.pushNamed(context, '/login'),
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
    );
  }
}
