import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPrefs {
  static Future<void> saveLoginPlatform(String platform) async {
    final prefs = await SharedPreferences.getInstance();
    unawaited(prefs.setString('loginPlatform', platform));
  }

  static Future<String?> getLoginPlatform() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get('loginPlatform') as String?;
  }
}
