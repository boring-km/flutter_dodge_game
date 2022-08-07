import 'package:get/get.dart';

class GameOverController extends GetxController {
  bool isGameOver = false;

  String _timeText = '';

  void gameOver(String timeText) {
    isGameOver = true;
    _timeText = timeText;
    update();
  }

  String getScoreText() {
    return 'Score: $_timeText';
  }
}
