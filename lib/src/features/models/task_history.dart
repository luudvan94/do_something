import 'dart:convert';

import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/task.dart';

class TaskHistory<T extends HistoryTypeDetails> {
  String id;

  String taskId;

  DateTime doneDate;

  String typeString;

  T details;

  TaskHistory(
      {this.id = '',
      required this.taskId,
      required this.doneDate,
      required this.typeString,
      required this.details}) {
    id = id.isEmpty ? DateTime.now().toString() : id;
  }

  HistoryType get type => HistoryTypeExtension.fromName(typeString);

  @override
  String toString() {
    // print task history object
    return 'TaskHistory{id: $id, taskId: $taskId, doneDate: $doneDate, typeString: $typeString}';
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'taskId': taskId,
      'doneDate': doneDate.toIso8601String(),
      'typeString': typeString,
      'details': details.toJSON(),
    });
  }

  static T detailsFromJson<T extends HistoryTypeDetails>(
      Map<String, dynamic> jsonMap, HistoryType type) {
    switch (type) {
      case HistoryType.complete:
        return HistoryTypeCompleteDetails.fromJson(jsonMap) as T;
      case HistoryType.create:
        return HistoryTypeCreateDetails.fromJson(jsonMap) as T;
      case HistoryType.update:
        return HistoryTypeUpdateDetails.fromJson(jsonMap) as T;
      case HistoryType.delete:
        return HistoryTypeDeleteDetails.fromJson(jsonMap) as T;
      default:
        throw Exception('Unknown history type');
    }
  }

  static TaskHistory fromJson(Map<String, dynamic> json) {
    return TaskHistory(
      id: json['id'],
      taskId: json['taskId'],
      doneDate: DateTime.parse(json['doneDate']),
      typeString: json['typeString'],
      details: detailsFromJson(
          json['details'], HistoryTypeExtension.fromName(json['typeString'])),
    );
  }

  static TaskHistory create(
    Task task,
  ) {
    var history =
        _createTaskHistory(task.id, null, null, task, HistoryType.create);

    if (history == null) {
      throw Exception('History details is null');
    }

    return history;
  }

  static TaskHistory complete(Task task, String comment) {
    var history =
        _createTaskHistory(task.id, comment, null, task, HistoryType.complete);

    if (history == null) {
      throw Exception('History details is null');
    }

    return history;
  }

  static TaskHistory update(Task task, List<TaskDifference> differences) {
    var history = _createTaskHistory(
        task.id, null, differences, task, HistoryType.update);

    if (history == null) {
      throw Exception('History details is null');
    }

    return history;
  }

  static TaskHistory delete(Task task) {
    var history =
        _createTaskHistory(task.id, null, null, task, HistoryType.delete);

    if (history == null) {
      throw Exception('History details is null');
    }

    return history;
  }

  static TaskHistory? _createTaskHistory<T extends HistoryTypeDetails>(
      String taskId,
      String? comment,
      List<TaskDifference>? differences,
      Task? task,
      HistoryType type) {
    HistoryTypeDetails? details;
    switch (type) {
      case HistoryType.create:
        details = task != null ? HistoryTypeCreateDetails(task: task) : null;
        break;
      case HistoryType.update:
        details = differences != null
            ? HistoryTypeUpdateDetails(differences: differences)
            : null;
        break;
      case HistoryType.complete:
        details = HistoryTypeCompleteDetails(comment: comment);
        break;
      default:
        details = task != null ? HistoryTypeDeleteDetails(task: task) : null;
        break;
    }

    if (details == null) {
      throw Exception('History details is null');
    }

    return TaskHistory(
        taskId: taskId,
        doneDate: DateTime.now(),
        typeString: type.toName(),
        details: details);
  }
}
