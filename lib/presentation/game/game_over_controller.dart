import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_timer_controller.dart';
import 'package:get/get.dart';

class GameOverController extends GetxController {
  bool isGameOver = false;
  String _timeText = '';
  final GameTimerController _timerController = Get.find<GameTimerController>();

  void gameOver(String timeText) {
    isGameOver = true;
    _timeText = timeText;
    update();
  }

  String getScoreText() {
    return 'Score: $_timeText';
  }

  Future<void> restart(DodgeGame dodgeGame) async {
    dodgeGame.restart();
    _timerController.restart();
    isGameOver = false;
    update();
  }
}
