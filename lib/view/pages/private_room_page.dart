import 'dart:async';
import 'package:flutter/material.dart';

import '../utils/buttons.dart';
import '../utils/logout_dialog.dart';
import '../../Constants/colors.dart';

class PrivateRoomPage extends StatefulWidget {
  const PrivateRoomPage({Key? key}) : super(key: key);

  @override
  _PrivateRoomPageState createState() => _PrivateRoomPageState();
}

class _PrivateRoomPageState extends State<PrivateRoomPage> {
  bool isInfoButtonHeld = false;

  void _showInfoDialog(BuildContext context) {
    Timer? timer;
    showDialog(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,
      builder: (context) {
        timer = Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
        return const AlertDialog(
          title: Text("Private Room Info"),
          content: Text(
            "Create or join private rooms for confidential and personalized conversations with selected members.",
          ),
        );
      },
    ).then((val) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Private Room'),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.white),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              isInfoButtonHeld = true;
              _showInfoDialog(context);
            });
          },
          child: const Icon(Icons.info_outline_rounded, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const LogOutDialog(),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Start your private journey now!",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.black,
                        letterSpacing: 0,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: const PrimaryButton(null, 'Create a Private Room'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: const PrimaryButton(null, 'Join a Private Room'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
