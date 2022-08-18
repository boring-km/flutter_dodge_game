import 'package:dodge_game/view/game/game_health_controller.dart';
import 'package:dodge_game/view/game/game_menu_controller.dart';
import 'package:dodge_game/view/game/game_over_controller.dart';
import 'package:dodge_game/view/game/game_timer_controller.dart';
import 'package:dodge_game/view/login/login_screen_controller.dart';
import 'package:dodge_game/view/menu/menu_screen_controller.dart';
import 'package:dodge_game/view/score/score_screen_controller.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginScreenController());
  }
}

class MenuScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuScreenController());
  }
}

class GameScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(GameMenuController())
      ..put(GameHealthController())
      ..put(GameTimerController())
      ..put(GameOverController());
  }
}

class ScoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScoreScreenController());
  }
}
