import 'package:dodge_game/presentation/game/game_health_controller.dart';
import 'package:dodge_game/presentation/game/game_menu_controller.dart';
import 'package:dodge_game/presentation/game/game_over_controller.dart';
import 'package:dodge_game/presentation/game/game_timer_controller.dart';
import 'package:dodge_game/presentation/menu/menu_screen_controller.dart';
import 'package:dodge_game/presentation/score/score_screen_controller.dart';
import 'package:get/get.dart';

class MenuScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuScreenController());
  }
}

class GameScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(GameMenuController())
      ..put(GameHealthController())
      ..put(GameTimerController())
      ..put(GameOverController());
  }
}

class ScoreScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ScoreScreenController());
  }
}
