import 'dart:async';

import 'package:dodge_game/provider/get_shared_prefs.dart';
import 'package:dodge_game/provider/shared_data.dart';
import 'package:dodge_game/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginController extends GetxController {
  Future<void> login() async {
    // full scopes: https://developers.google.com/identity/protocols/oauth2/scopes
    final auth = FirebaseAuth.instance;
    final googleSignInAccount = await GoogleSignIn(scopes: ['email']).signIn();
    if (googleSignInAccount != null) {
      final credential = await _getCredential(googleSignInAccount);

      try {
        final userCredential = await auth.signInWithCredential(credential);
        final user = userCredential.user;
        await LoginSharedPrefs.saveLoginPlatform('google');
        await SharedData.saveUser(user?.email, user?.displayName);

        if (user != null) {
          unawaited(Get.offAndToNamed('/menu'));
        }
      } catch (error) {
        Log.e('google login error: $error}');
      }
    }
  }

  Future<AuthCredential> _getCredential(
      GoogleSignInAccount googleSignInAccount) async {
    final googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return credential;
  }
}
