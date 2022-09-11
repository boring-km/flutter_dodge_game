// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRecord _$GameRecordFromJson(Map<String, dynamic> json) => GameRecord(
  json['num'] as int,
  json['time'] as String,
  json['userName'] as String,
);

Map<String, dynamic> _$GameRecordToJson(GameRecord instance) =>
    <String, dynamic>{
      'num': instance.num,
      'time': instance.time,
      'userName': instance.userName,
    };
