import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isNextSame) const SizedBox(height: 20),
                      if (!isNextSame && !myMessage)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            currUser['userName'],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                          maxHeight: MediaQuery.sizeOf(context).height * 0.6,
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        color: (myMessage)
                            ? primaryColor
                            : primaryColor.withOpacity(0.7),
                        child: Scrollbar(
                          interactive: true,
                          scrollbarOrientation: (myMessage)
                              ? ScrollbarOrientation.right
                              : ScrollbarOrientation.left,
                          child: SelectableText(
                            currUser['message'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                            enableInteractiveSelection: true,
                            maxLines: 30,
                            minLines: 1,
                          ),
                        ),
                      ),
                    ],
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
                      .copyWith(color: primaryColor)));
        }
      },
    );
  }
}
