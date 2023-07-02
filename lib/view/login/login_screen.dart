import 'package:dodge_game/view/login/google_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

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
              const SizedBox(
                height: 16,
              ),
              GetBuilder<GoogleLoginController>(
                builder: (controller) {
                  return SignInButton(
                    Buttons.Google,
                    onPressed: controller.login,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
