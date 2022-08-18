import 'package:dodge_game/di/bindings.dart';
import 'package:dodge_game/view/game/game_screen.dart';
import 'package:dodge_game/view/login/login_screen.dart';
import 'package:dodge_game/view/menu/menu_screen.dart';
import 'package:dodge_game/view/score/score_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const login = '/login';
  static const menu = '/menu';
  static const game = '/game';
  static const score = '/score';
}

class Pages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: Routes.menu,
      page: () => const MenuScreen(),
      binding: MenuScreenBinding(),
    ),
    GetPage(
      name: '/game',
      page: () => const GameScreen(),
      binding: GameScreenBinding(),
    ),
    GetPage(
      name: '/score',
      page: () => const ScoreScreen(),
      binding: ScoreScreenBinding(),
    ),
  ];
}
