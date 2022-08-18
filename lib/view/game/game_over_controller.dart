import 'dart:async';

import 'package:dodge_game/data/game_record.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/provider/get_firebase.dart';
import 'package:dodge_game/utils/logger.dart';
import 'package:dodge_game/view/game/game_timer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GameOverController extends GetxController {
  bool isGameOver = false;
  String _timeText = '';
  final GameTimerController _timerController = Get.find<GameTimerController>();

  void gameOver(String timeText) {
    _saveScore(timeText.replaceAll('s', ''));
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

  Future<void> _saveScore(String time) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    Log.i('User nickname: ${currentUser?.displayName}');

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    unawaited(
      FireStore.saveScore(
        GameRecord(
          int.parse(time),
          formattedDate,
          currentUser?.displayName ?? '',
        ),
      ),
    );
  }

  Future<dynamic>? moveToScoreScreen() => Get.offAndToNamed('/score');
}
