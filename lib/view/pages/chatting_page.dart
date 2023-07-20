import 'package:flutter/material.dart';

import '../utils/logout_dialog.dart';
import '../../controllers/send_mesaage_textfield.dart';
import '../../services/auth_service.dart';
import '../utils/chat_messages.dart';
import '../../Constants/colors.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);
  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  TextEditingController chatController = TextEditingController();
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
          backgroundColor: primaryColor,
          title: Text("Whisper Here...",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white)),
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: const Icon(Icons.logout_rounded,
                    color: Colors.white, size: 30),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const LogOutDialog());
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
                const Expanded(child: ChatMessages()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SendMessage(chatController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
