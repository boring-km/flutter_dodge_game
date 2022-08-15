import 'package:dodge_game/core/get_hive_box.dart';
import 'package:dodge_game/data/game_record.dart';
import 'package:get/get.dart';

class ScoreScreenController extends GetxController {

  List<GameRecord> _scoreList = [];
  List<GameRecord> get scoreList => _scoreList;

  Future<void> getScores() async {
    final records = <GameRecord>[];
    final scoreBox = await openGameRecordBox();

    final values = scoreBox.values.toList()
        ..sort((GameRecord a, GameRecord b) => a.num.compareTo(b.num));

    for (final score in values) {
      records.add(score);
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
