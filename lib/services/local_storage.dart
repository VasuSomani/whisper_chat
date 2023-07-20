import "package:shared_preferences/shared_preferences.dart";

class LocalStorage {
  void postLocally(String uid) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("anonymousKey", uid);
  }

  Future<String?> getLocally() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString("anonymousKey");
  }
}
