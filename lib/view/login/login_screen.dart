
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Dodge Game',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 64,
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  // full scopes: https://developers.google.com/identity/protocols/oauth2/scopes
                  final _googleSignIn = GoogleSignIn(
                    scopes: [
                      'email',
                      'https://www.googleapis.com/auth/contacts.readonly',
                    ],
                  );
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
                      print('error');
                    }
                  }
                },
              ),
              SignInButton(
                Buttons.Apple,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
