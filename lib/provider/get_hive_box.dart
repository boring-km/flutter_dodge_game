import 'package:dodge_game/data/game_record.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<Box<GameRecord>> openGameRecordBox() async {
  const boxName = 'score';
  if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
    Hive
      ..init((await getApplicationDocumentsDirectory()).path)
      ..registerAdapter(GameRecordAdapter());
  }

  return Hive.openBox(boxName);
}
