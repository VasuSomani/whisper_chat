import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../view/utils/custom_snackbar.dart';

class RoomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static List<String> lastFiveRooms = [];
  Future<String> createPrivateRoom() async {
    String roomID = generateUUID();
    if (lastFiveRooms.length >= 5) {
      lastFiveRooms.removeAt(0);
      lastFiveRooms.add(roomID);
      debugPrint(lastFiveRooms.toString());
    } else {
      lastFiveRooms.add(roomID);
      debugPrint(lastFiveRooms.toString());
    }
    await _db.collection('rooms').doc(roomID).set({});
    return roomID;
  }

  Future joinPrivateRoom(String roomID, BuildContext context) async {
    bool isRoomExists = await checkRoomID(roomID);
    Navigator.pop(context);
    if (isRoomExists) {
      debugPrint("ROOM FOUND");
      Navigator.pushNamed(context, '/chat', arguments: roomID);
      if (lastFiveRooms.contains(roomID)) {
        lastFiveRooms.remove(roomID);
        lastFiveRooms.add(roomID);
        debugPrint(lastFiveRooms.toString());
      } else {
        if (lastFiveRooms.length == 5) {
          lastFiveRooms.removeAt(0);
          lastFiveRooms.add(roomID);
          debugPrint(lastFiveRooms.toString());
        } else {
          lastFiveRooms.add(roomID);
          debugPrint(lastFiveRooms.toString());
        }
      }
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
