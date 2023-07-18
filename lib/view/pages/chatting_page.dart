import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../controllers/auth_text_fields.dart';

class ChattingPage extends StatelessWidget {
  ChattingPage({Key? key}) : super(key: key);
  TextEditingController chatController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void sendMessage() {
    if (formKey.currentState!.validate()) {
      chatController.clear();
    }
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
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.logout_rounded, color: Colors.white, size: 30),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IntrinsicHeight(
                          child: TextFormField(
                            controller: chatController,
                            textInputAction: TextInputAction.next,
                            minLines: 1,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              filled: true,
                              fillColor: textFieldBg,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                            ),
                            validator: (value) {
                              if (value == null || value.trim() == "") {
                                return null;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: sendMessage,
                        child: ClipOval(
                          child: Container(
                            height: 50,
                            width: 50,
                            color: primaryColor,
                            child: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
