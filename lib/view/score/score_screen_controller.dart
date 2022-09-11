import 'package:dodge_game/domain/model/game_record.dart';
import 'package:dodge_game/provider/get_firebase.dart';
import 'package:get/get.dart';

class ScoreScreenController extends GetxController {
  List<GameRecord> _scoreList = [];

  List<GameRecord> get scoreList => _scoreList;

  Future<void> getScores() async {
    final records = <GameRecord>[];
    FireStore.getData((docs) {
      for (final doc in docs) {
        records.add(doc.data());
      }
      _scoreList = records;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getScores();
  }
}
