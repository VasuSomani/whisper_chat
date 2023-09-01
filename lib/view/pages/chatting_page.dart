import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../controllers/send_mesaage_textfield.dart';
import '../../services/auth_service.dart';
import '../utils/chat_messages.dart';
import '../../Constants/colors.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key, required this.roomID}) : super(key: key);
  final String roomID;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Private Room",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white)),
            TextButton(
              onPressed: () =>
                  Clipboard.setData(ClipboardData(text: widget.roomID)),
              child: Text(widget.roomID,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white)),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: ChatMessages(roomID: widget.roomID)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SendMessage(
                    chatController: chatController, roomID: widget.roomID),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
