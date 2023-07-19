import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper_chat/controllers/auth_textfields.dart';
import 'package:whisper_chat/services/auth_service.dart';
import 'package:whisper_chat/view/utils/buttons.dart';
import 'package:whisper_chat/view/utils/snackbar.dart';

import '../../Constants/colors.dart';

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
          showCustomSnackBar("Logged In Anonymously", context);
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
            title: Text("Enter username"),
            titleTextStyle: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: TextFieldUserName(usernameController),
                ),
                SizedBox(height: 40),
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
