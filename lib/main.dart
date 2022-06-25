import 'package:dodge_game/di/bindings.dart';
import 'package:dodge_game/presentation/game/game_screen.dart';
import 'package:dodge_game/presentation/menu/menu_screen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/menu',
      getPages: [
        GetPage(name: '/menu', page: () => const MenuScreen(), binding: MenuScreenBindings()),
        GetPage(name: '/game', page: () => const GameScreen(), binding: GameScreenBindings()),
      ],
    );
  }
}
