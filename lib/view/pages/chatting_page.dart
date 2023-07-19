import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/send_mesaage_textfield.dart';
import '../../services/auth_service.dart';
import '../utils/chat_messages.dart';
import '../../Constants/colors.dart';
import '../utils/buttons.dart';
import '../utils/snackbar.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);
  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  TextEditingController chatController = TextEditingController();
  bool isLoading = false;
  AuthService authService = AuthService();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Whisper Here...",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white)),
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(Icons.logout_rounded, color: Colors.white, size: 30),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Confirm Logout'),
                            titleTextStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                            content:
                                const Text('Are you sure you want to logout?'),
                            contentTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
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
                              PrimaryButton(() async {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await authService.signOut().then((value) {
                                    showCustomSnackBar(
                                        "Logged out successfully", context);
                                    Navigator.pop(context);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  });
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showCustomSnackBar(e.toString(), context,
                                      isAlert: true);
                                }
                              }, "Log Out", isLoading: isLoading),
                            ],
                          ));
                },
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: ChatMessages()),
                SendMessage(chatController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
