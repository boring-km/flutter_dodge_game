import 'package:dodge_game/core/get_hive_box.dart';
import 'package:dodge_game/data/game_record.dart';
import 'package:get/get.dart';

class ScoreScreenController extends GetxController {

  List<GameRecord> _scoreList = [];
  List<GameRecord> get scoreList => _scoreList;

  Future<void> getScores() async {
    final records = <GameRecord>[];
    final scoreBox = await openGameRecordBox();

    for (final key in scoreBox.keys) {
      final score = scoreBox.get(key);
      if (score != null) {
        records.add(score);
      }
    }
    _scoreList = records;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getScores();
  }
}
