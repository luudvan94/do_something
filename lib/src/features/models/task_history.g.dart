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
    )..description = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, TaskHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.doneDate)
      ..writeByte(3)
      ..write(obj.description);
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
