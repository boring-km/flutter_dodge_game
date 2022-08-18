import 'package:json_annotation/json_annotation.dart';

part 'game_record.g.dart';

@JsonSerializable(explicitToJson: true)
class GameRecord {
  GameRecord(this.num, this.time, this.userName);

  factory GameRecord.fromJson(Map<String, dynamic> json) =>
      _$GameRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GameRecordToJson(this);

  final int num;

  final String time;

  final String userName;

  @override
  String toString() {
    return 'score: $num, time: $time, user: $userName';
  }
}
