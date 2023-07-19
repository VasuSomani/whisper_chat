class UserModel {
  final String? uid;
  final String? userName;
  final String? email;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
  });

  toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
    };
  }
}
