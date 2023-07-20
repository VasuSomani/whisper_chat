import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../controllers/auth_textfields.dart';
import '../../services/auth_service.dart';
import '../utils/buttons.dart';
import '../utils/snackbar.dart';

bool isLoading = false;
AuthService authService = AuthService();
TextEditingController usernameController = TextEditingController();
final formKey = GlobalKey<FormState>();

class UserName extends StatefulWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  void authorizeAnonymous() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        authService
            .signInAnonymously(usernameController.text.toString())
            .then((value) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacementNamed(context, '/chat');
          usernameController.clear();
          showCustomSnackBar("You are anonymous now", context);
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
    return WillPopScope(
      onWillPop: () async {
        usernameController.clear();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: primaryColor,
              title: const Text("Enter username"),
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white)),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: TextFieldUserName(usernameController),
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  authorizeAnonymous,
                  "Proceed",
                  isLoading: isLoading,
                )
              ],
            ),
          )),
    );
  }
}
