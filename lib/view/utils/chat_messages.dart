import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper_chat/Constants/colors.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String currUid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: db
          .collection('chats')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              bool myMessage = false;
              bool isNextSame = false;
              final currUser = snapshot.data!.docs[index].data();
              if (currUser['uid'] == currUid) {
                myMessage = true;
              }
              if (snapshot.hasData && index + 1 < snapshot.data!.docs.length) {
                final nextUser = snapshot.data!.docs[index + 1].data();
                isNextSame = currUser['uid'] == nextUser['uid'];
              }

              return Row(
                mainAxisAlignment: (myMessage)
                    ? (MainAxisAlignment.end)
                    : (MainAxisAlignment.start),
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    color: ColorScheme.fromSeed(seedColor: primaryColor)
                        .primaryContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isNextSame && !myMessage)
                          Text(
                            currUser['userName'],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        Text(
                          currUser['message'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        } else {
          return Center(
              child: Text("No chat to display",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: darkGrey)));
        }
      },
    );
  }
}
