import 'package:dodge_game/data/game_record.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_timer_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

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
    final scoreBox = await _openHiveBox('score');
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    await scoreBox.add(
      GameRecord(
        int.parse(time),
        formattedDate,
        'testUserName',
      ),
    );
    for (final key in scoreBox.keys) {
      print(scoreBox.get(key));
    }
  }

  Future<Box<GameRecord>> _openHiveBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
      Hive
        ..init((await getApplicationDocumentsDirectory()).path)
        ..registerAdapter(GameRecordAdapter());
    }

    return Hive.openBox(boxName);
  }
}
