import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  Future<bool> setAuthToken(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.AuthToken.toString(), key);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(UserPref.AuthToken.toString());
  }
}

enum UserPref { AuthToken }
