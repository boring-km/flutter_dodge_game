
import 'package:dodge_game/di/bindings.dart';
import 'package:dodge_game/firebase_options.dart';
import 'package:dodge_game/presentation/game/game_screen.dart';
import 'package:dodge_game/presentation/menu/menu_screen.dart';
import 'package:dodge_game/presentation/score/score_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/menu',
      theme: ThemeData(
        fontFamily: 'Merriweather',
      ),
      getPages: [
        GetPage(
          name: '/menu',
          page: () => const MenuScreen(),
          binding: MenuScreenBindings(),
        ),
        GetPage(
          name: '/game',
          page: () => const GameScreen(),
          binding: GameScreenBindings(),
        ),
        GetPage(
          name: '/score',
          page: () => const ScoreScreen(),
          binding: ScoreScreenBindings(),
        ),
      ],
    );
  }
}
