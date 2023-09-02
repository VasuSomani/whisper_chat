import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'custom_buttons.dart';
import '../../services/room_service.dart';
import '../../Constants/colors.dart';

void showJoinRoomDialog(BuildContext context) {
  String roomID = "";
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text('Enter Room ID', style: TextStyle(fontSize: 25)),
      actionsPadding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(color: primaryColor, fontSize: 15)),
        ),
        PrimaryButton(() async {
          await RoomService().joinPrivateRoom(roomID, context);
        }, "Join"),
      ],
      content: OtpTextField(
        numberOfFields: 6,
        focusedBorderColor: primaryColor,
        keyboardType: TextInputType.text,
        borderRadius: BorderRadius.circular(10),
        showCursor: false,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        showFieldAsBox: true,
        cursorColor: primaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        onSubmit: (value) async {
          roomID = value;
          await RoomService().joinPrivateRoom(roomID, context);
        },
      ),
    ),
  );
}
