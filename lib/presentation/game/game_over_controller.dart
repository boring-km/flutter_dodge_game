import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_timer_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    final path = join(await getDatabasesPath(), 'score.db');
    await deleteDatabase(path);

    // final db = await _getDb();
    // final now = DateTime.now();
    // final formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    //
    // await db.transaction((txn) async {
    //   await txn.rawInsert(
    //     'INSERT INTO Score(num, time) VALUES($time, "$formattedDate")',
    //   );
    // });
    //
    // final list = await db.rawQuery('SELECT * FROM Score');
    // for (final item in list) {
    //   print(item);
    // }
  }

  Future<Database> _getDb() async {
    final path = join(await getDatabasesPath(), 'score.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
          CREATE TABLE Score(
            id INTEGER PRIMARY KEY,
            num INTEGER,
            time VARCHAR(30) 
          );
        ''',
        );
      },
    );
    return db;
  }
}
