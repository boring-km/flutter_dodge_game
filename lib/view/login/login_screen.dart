import 'package:dodge_game/view/login/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<LoginScreenController>(builder: (controller) {
            return Column(
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
                SignInButton(
                  Buttons.Google,
                  text: 'Google Login',
                  onPressed: controller.login,
                ),
                SignInButton(
                  Buttons.Apple,
                  text: 'Apple Login',
                  onPressed: () {},
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
