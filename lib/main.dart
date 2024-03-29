import 'package:dodge_game/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Firebase.initializeApp();

  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firstPage =
        FirebaseAuth.instance.currentUser != null ? Routes.menu : Routes.login;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: firstPage,
      theme: _buildTheme(context),
      getPages: Pages.pages,
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    final baseTheme = ThemeData(brightness: Brightness.light);
    return baseTheme.copyWith(
      textTheme: GoogleFonts.robotoMonoTextTheme(baseTheme.textTheme),
    );
  }
}
