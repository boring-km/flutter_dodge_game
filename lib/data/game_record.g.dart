// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameRecordAdapter extends TypeAdapter<GameRecord> {
  @override
  final int typeId = 1;

  @override
  GameRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameRecord(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GameRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.num)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.userName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
