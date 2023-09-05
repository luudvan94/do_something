// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskHistoryAdapter extends TypeAdapter<TaskHistory> {
  @override
  final int typeId = 1;

  @override
  TaskHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskHistory(
      id: fields[0] as String,
      taskId: fields[1] as String,
      doneDate: fields[2] as DateTime,
      historyTypeId: fields[4] as String,
      typeString: fields[3] as String,
      detailsJsonString: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.doneDate)
      ..writeByte(3)
      ..write(obj.typeString)
      ..writeByte(4)
      ..write(obj.historyTypeId)
      ..writeByte(5)
      ..write(obj.detailsJsonString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
