import 'dart:async';

import 'package:dodge_game/provider/get_shared_prefs.dart';
import 'package:dodge_game/provider/shared_data.dart';
import 'package:dodge_game/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class MenuScreenController extends GetxController {
  Future<dynamic>? startGame() => Get.toNamed('/game');

  Future<dynamic>? getScore() => Get.toNamed('/score');

  String name = '';

  @override
  void onInit() {
    getName();
    super.onInit();
  }

  Future<void> logout() async {
    final loggedPlatform = await LoginSharedPrefs.getLoginPlatform();
    await LoginSharedPrefs.saveLoginPlatform('');
    if (loggedPlatform == 'google') {
      await FirebaseAuth.instance.signOut();
      final googleSignIn = GoogleSignIn();
      try {
        await googleSignIn.signOut();
      } catch (e) {
        Log.e('Logout Error: $e');
      }
      unawaited(Get.offAllNamed<dynamic>('/login'));
    } else if (loggedPlatform == 'kakao') {
      await UserApi.instance.logout();
      unawaited(Get.offAllNamed<dynamic>('/login'));
    }
  }

  Future<void> getName() async {
    Future.delayed(const Duration(milliseconds: 300), () async {
      name = await SharedData.getUserName();
      update();
    });
  }
}
