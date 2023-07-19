import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whisper_chat/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Login with Email and Password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return result;
  }

  //Anonymous Login
  Future signInAnonymously(String userName) async {
    final result = await _auth.signInAnonymously();
    String uid = result.user!.uid;
    createUser(userName: userName, email: "ANONYMOUS", uid: uid);
  }

  //Signup with Email, Password and Name
  Future signUpWithUserData(
      {required String email,
      required String password,
      required String userName}) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = result.user!.uid;
    createUser(userName: userName, email: email, uid: uid);
  }

  //Log out
  signOut() async {
    _auth.signOut();
  }

  // Create User in Firestore Database
  Future createUser(
      {required String userName,
      required String email,
      required String uid}) async {
    await _db
        .collection('users')
        .doc(uid)
        .set(UserModel(uid: uid, userName: userName, email: email).toJson());
  }
}
