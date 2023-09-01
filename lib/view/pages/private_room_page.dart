import 'dart:async';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import '../utils/join_room_dialog.dart';
import '../../services/room_service.dart';
import '../utils/custom_buttons.dart';
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
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(
            "Back again to exit",
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white),
          ),
          backgroundColor: primaryColor,
          closeIconColor: Colors.white,
          showCloseIcon: true,
          dismissDirection: DismissDirection.down,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
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
                Image.asset("assets/images/astronaut.png"),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: PrimaryButton(() {
                    String roomID = RoomService().createPrivateRoom();
                    Navigator.pushNamed(context, '/chat', arguments: roomID);
                  }, 'Create a Private Room'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: PrimaryButton(() {
                    // RoomService().joinPrivateRoom(uuid)
                    showJoinRoomDialog(context);
                  }, 'Join a Private Room'),
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
