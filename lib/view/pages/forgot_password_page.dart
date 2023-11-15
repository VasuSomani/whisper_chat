import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../controllers/auth_textfields.dart';
import '../../services/auth_service.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_snackbar.dart';

bool isLoading = false;
AuthService authService = AuthService();
TextEditingController emailController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void dispose() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
  }

  void sendResetLink() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        authService
            .forgotPassword(emailController.text.toString())
            .then((value) {
          setState(() {
            isLoading = false;
          });
          emailController.clear();
          showCustomSnackBar(
              "Password rest link has been sent to your email address",
              context);
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Enter email address"),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: TextFieldEmail(emailController),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                sendResetLink,
                "Proceed",
                isLoading: isLoading,
              )
            ],
          ),
        ));
  }
}
