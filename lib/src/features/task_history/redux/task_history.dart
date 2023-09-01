import 'package:hive/hive.dart';

part 'task_history.g.dart';

@HiveType(typeId: 1)
class TaskHistory extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String taskId;

  @HiveField(2)
  DateTime doneDate;

  @HiveField(3)
  String? description;

  TaskHistory({
    this.id = '',
    required this.taskId,
    required this.doneDate,
  }) {
    id = id.isEmpty ? DateTime.now().toString() : id;
  }

  @override
  String toString() {
    return 'TaskHistory{id: $id, taskId: $taskId, doneDate: $doneDate, description: $description}';
  }
}
