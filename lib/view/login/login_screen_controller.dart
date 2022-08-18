import 'dart:async';

import 'package:dodge_game/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController extends GetxController {
  Future<void> login() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // full scopes: https://developers.google.com/identity/protocols/oauth2/scopes
      final _googleSignIn = GoogleSignIn(scopes: ['email']);
      final auth = FirebaseAuth.instance;
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final userCredential = await auth.signInWithCredential(credential);
          final user = userCredential.user;
          if (user != null) {
            unawaited(Get.offAndToNamed('/menu'));
          }
        } on Exception {
          Log.e('error');
        }
      }
    } else {
      unawaited(Get.offAndToNamed('/menu'));
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.microtask(login);
  }
}
