import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../Constants/colors.dart';
import 'auth_textfields.dart';

class SendMessage extends StatefulWidget {
  const SendMessage(this.chatController, {Key? key}) : super(key: key);
  final TextEditingController chatController;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  late Future<UserModel> _userModelFuture;
  final FocusNode _messageFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userModelFuture = getCurrUser();
  }

  Future<UserModel> getCurrUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final userSnapshot = await db.collection('users').doc(uid).get();
    return UserModel(
      uid: uid,
      userName: userSnapshot['userName'],
      email: userSnapshot['email'],
    );
  }

  void sendMessage() async {
    UserModel currUser = await getCurrUser();
    if (widget.chatController.text.trim().isNotEmpty) {
      FirebaseFirestore.instance.collection('chats').add({
        'uid': currUser.uid,
        'userName': currUser.userName,
        'message': widget.chatController.text.toString(),
        'timestamp': DateTime.now().toString()
      });
      widget.chatController.clear();
      _messageFocusNode.requestFocus(); // Set focus back to the TextFormField
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _userModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IntrinsicHeight(
                    child: TextFormField(
                      controller: widget.chatController,
                      focusNode: _messageFocusNode,
                      textInputAction: TextInputAction.next,
                      minLines: 1,
                      maxLines: 10,
                      autocorrect: false,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: "Message",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        filled: true,
                        fillColor: textFieldBg,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                      ),
                      onFieldSubmitted: (value) => sendMessage(),
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
          );
        }
      },
    );
  }
}
