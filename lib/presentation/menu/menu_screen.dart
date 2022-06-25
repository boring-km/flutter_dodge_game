import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu_screen_controller.dart';

class MenuScreen extends GetView<MenuScreenController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: controller.startGame,
            child: const Text('게임 시작'),
          ),
        ),
      ),
    );
  }
}
