import 'package:dodge_game/game/game.dart';
import 'package:get/get.dart';

class GameMenuController extends GetxController {
  bool isPaused = false;

  // late GameOverController _gameOverController;

  @override
  void onInit() {
    // _gameOverController = Get.put(GameOverController());
    super.onInit();
  }

  void toggleGameState(DodgeGame dodgeGame) {
    if (isGameOver()) {}
    if (isPaused) {
      dodgeGame.resumeGame();
      isPaused = false;
    } else {
      dodgeGame.pauseGame();
      isPaused = true;
    }
    update();
  }

  bool isGameOver() {
    return true; // _gameOverController.isGameOver;
  }
}
