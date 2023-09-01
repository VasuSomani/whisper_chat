import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../view/utils/custom_snackbar.dart';

class RoomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String createPrivateRoom() {
    String roomID = generateUUID();
    _db.collection('rooms').doc(roomID).set({});
    return roomID;
  }

  Future joinPrivateRoom(String roomID, BuildContext context) async {
    bool isRoomExists = await checkRoomID(roomID);
    Navigator.pop(context);
    if (isRoomExists) {
      debugPrint("ROOM FOUND");
      Navigator.pushNamed(context, '/chat', arguments: roomID);
    } else {
      debugPrint("ROOM NOT FOUND");
      showCustomSnackBar("Room doesnot exists", context, isAlert: true);
    }
  }

  Future<bool> checkRoomID(String roomID) async {
    try {
      DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomID)
          .get();
      debugPrint(roomSnapshot.exists.toString());
      debugPrint(roomSnapshot.id.toString());
      debugPrint(roomID);
      return roomSnapshot.exists;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  String generateUUID() {
    const uuid = Uuid();
    String randomUuid = uuid.v4();
    return randomUuid.substring(0, 6);
  }
}
