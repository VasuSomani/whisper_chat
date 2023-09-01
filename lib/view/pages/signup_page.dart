import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../Constants/colors.dart';
import '../utils/custom_buttons.dart';
import '../../controllers/auth_textfields.dart';
import '../utils/custom_snackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  bool isLoading = false;
  TextEditingController userName = TextEditingController();
  TextEditingController emailID = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

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
          Navigator.pushReplacementNamed(context, '/private_room');
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        showCustomSnackBar(e.message.toString(), context, isAlert: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Create an Account"),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.white),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 15),
            child: Column(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height / 100),
                          child: TextFieldUserName(userName,
                              enableValidation: true),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: height / 100),
                          child:
                              TextFieldEmail(emailID, enableValidation: true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 100),
                          child:
                              TextFieldPass(password, enableValidation: true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height / 100),
                          child: TextFieldConfirmPass(confirmPassword, password,
                              enableValidation: true),
                        ),
                      ],
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
                          "Already have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () =>
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
    );
  }
}
