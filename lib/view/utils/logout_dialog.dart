import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import 'custom_snackbar.dart';
import '../../Constants/colors.dart';
import 'custom_buttons.dart';

class LogOutDialog extends StatefulWidget {
  const LogOutDialog({Key? key, this.isRoom = false}) : super(key: key);
  final bool isRoom;
  @override
  State<LogOutDialog> createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  bool isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text((widget.isRoom) ? 'Warning' : 'Confirm Logout'),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: primaryColor, fontWeight: FontWeight.w900, fontSize: 20),
      content: Text((widget.isRoom)
          ? 'You are going to leave this room. But your data will still be there'
          : 'Are you sure you want to logout?'),
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
              if (!widget.isRoom) {
                await authService.signOut().then((value) {
                  showCustomSnackBar("Logged out successfully", context);
                  Navigator.pop(context);
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushReplacementNamed(context, '/login');
                });
              } else {
                Navigator.pushReplacementNamed(context, '/private_room');
              }
            } on FirebaseAuthException catch (e) {
              setState(() {
                isLoading = false;
              });
              showCustomSnackBar(e.toString(), context, isAlert: true);
            }
          }, (widget.isRoom) ? "Confirm" : "Log Out", isLoading: isLoading),
        ),
      ],
    );
  }
}
