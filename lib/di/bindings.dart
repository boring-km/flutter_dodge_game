import 'package:dodge_game/presentation/game/game_menu_controller.dart';
import 'package:dodge_game/presentation/game/game_screen_controller.dart';
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
      ..put(GameScreenController());
  }
}

class ScoreScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ScoreScreenController());
  }
}
