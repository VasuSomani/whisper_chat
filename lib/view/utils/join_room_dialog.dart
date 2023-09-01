import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../services/room_service.dart';
import '../../Constants/colors.dart';

void showJoinRoomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text('Enter Room ID'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(color: primaryColor, fontSize: 15)),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(primaryColor),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10))),
          onPressed: () {},
          child: const Text('Join', style: TextStyle(fontSize: 15)),
        ),
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
          await RoomService().joinPrivateRoom(value, context);
        },
      ),
    ),
  );
}
