import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import 'snackbar.dart';
import '../../Constants/colors.dart';
import 'buttons.dart';

class LogOutDialog extends StatefulWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  State<LogOutDialog> createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  bool isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: primaryColor, fontWeight: FontWeight.w900, fontSize: 20),
      content: const Text('Are you sure you want to logout?'),
      contentTextStyle:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: primaryColor)),
        ),
        SizedBox(
          height: 50,
          child: PrimaryButton(() async {
            try {
              setState(() {
                isLoading = true;
              });
              await authService.signOut().then((value) {
                showCustomSnackBar("Logged out successfully", context);
                Navigator.pop(context);
                setState(() {
                  isLoading = false;
                });
                Navigator.pushReplacementNamed(context, '/login');
              });
            } on FirebaseAuthException catch (e) {
              setState(() {
                isLoading = false;
              });
              showCustomSnackBar(e.toString(), context, isAlert: true);
            }
          }, "Log Out", isLoading: isLoading),
        ),
      ],
    );
  }
}
