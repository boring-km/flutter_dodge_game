import 'dart:async';

import 'package:dodge_game/provider/get_shared_prefs.dart';
import 'package:dodge_game/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuScreenController extends GetxController {
  Future<dynamic>? startGame() => Get.toNamed('/game');

  Future<dynamic>? getScore() => Get.toNamed('/score');

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    final loggedPlatform = await LoginSharedPrefs.getLoginPlatform();
    if (loggedPlatform == Buttons.Google.name ||
        loggedPlatform == Buttons.GoogleDark.name) {
      final googleSignIn = GoogleSignIn();
      try {
        await googleSignIn.signOut();
        await LoginSharedPrefs.saveLoginPlatform('');
      } catch (e) {
        Log.e('Logout Error: $e');
      }
    }

    unawaited(Get.offAllNamed<dynamic>('/login'));
  }
}
