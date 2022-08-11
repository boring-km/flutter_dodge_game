import 'package:hive/hive.dart';

part 'game_record.g.dart';

@HiveType(typeId: 1)
class GameRecord extends HiveObject {
  GameRecord(this.num, this.time, this.userName);

  @HiveField(0)
  final int num;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final String userName;

  @override
  String toString() {
    return 'score: $num, time: $time, user: $userName';
  }
}
