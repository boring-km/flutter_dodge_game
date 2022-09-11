import 'package:dodge_game/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static Future<void> saveUser(String? email, String? name) async {
    final prefs = await SharedPreferences.getInstance();

    if (email != null) {
      await prefs.setString('email', email);
    }

    if (name != null) {
      await prefs.setString('name', name);
    }

    Log.i(
      'saved email: ${prefs.getString('email')},'
      ' name: ${prefs.getString('name')}',
    );
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '이름 없음';
  }
}
