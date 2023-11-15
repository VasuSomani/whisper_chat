import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../controllers/auth_textfields.dart';
import '../../services/auth_service.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_snackbar.dart';

bool isLoading = false;
AuthService authService = AuthService();
TextEditingController usernameController = TextEditingController();
final formKey = GlobalKey<FormState>();

class AnonymousLogin extends StatefulWidget {
  const AnonymousLogin({Key? key}) : super(key: key);

  @override
  State<AnonymousLogin> createState() => _AnonymousLoginState();
}

class _AnonymousLoginState extends State<AnonymousLogin> {
  @override
  void dispose() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
  }

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
          Navigator.pushReplacementNamed(context, '/private_room');
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
            backgroundColor: primaryColor,
            title: const Text("Enter username"),
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
                  child: TextFieldUserName(usernameController,
                      enableValidation: true),
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
