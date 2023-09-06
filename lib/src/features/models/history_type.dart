import 'dart:convert';

import 'package:do_something/src/features/models/task.dart';

enum HistoryType {
  complete,
  create,
  update,
  delete,
}

extension HistoryTypeExtension on HistoryType {
  String toName() {
    return toString().split('.').last;
  }

  static HistoryType fromName(String name) {
    return HistoryType.values.firstWhere((element) => element.toName() == name);
  }
}

class TaskDifference {
  final String oldValue;
  final String newValue;

  TaskDifference(this.oldValue, this.newValue);
}

abstract class HistoryTypeDetails {
  final String id;

  HistoryTypeDetails({String? id}) : id = id ?? DateTime.now().toString();

  String toJSON() {
    return jsonEncode({
      'id': id,
    });
  }
}

class HistoryTypeCompleteDetails implements HistoryTypeDetails {
  @override
  final String id;

  final String? comment;

  HistoryTypeCompleteDetails({String? id, this.comment})
      : id = id ?? DateTime.now().toString();

  @override
  String toJSON() {
    return jsonEncode({
      'id': id,
      'comment': comment,
    });
  }

  factory HistoryTypeCompleteDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeCompleteDetails(
      id: json['id'],
      comment: json['comment'],
    );
  }

  factory HistoryTypeCompleteDetails.fromComment(String comment) {
    return HistoryTypeCompleteDetails(comment: comment);
  }
}

class HistoryTypeCreateDetails implements HistoryTypeDetails {
  @override
  final String id;

  final Task task;

  HistoryTypeCreateDetails({String? id, required this.task})
      : id = id ?? DateTime.now().toString();

  @override
  String toJSON() {
    return jsonEncode({
      'id': id,
      'task': task.toJson(),
    });
  }

  factory HistoryTypeCreateDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeCreateDetails(
      id: json['id'],
      task: Task.fromJson(jsonDecode(json['task'])),
    );
  }

  factory HistoryTypeCreateDetails.fromTask(Task task) {
    return HistoryTypeCreateDetails(task: task);
  }
}

class HistoryTypeUpdateDetails implements HistoryTypeDetails {
  @override
  final String id;

  final List<TaskDifference> differences;

  HistoryTypeUpdateDetails({String? id, required this.differences})
      : id = id ?? DateTime.now().toString();

  @override
  String toJSON() {
    return jsonEncode({
      'id': id,
      'differences': differences,
    });
  }

  factory HistoryTypeUpdateDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeUpdateDetails(
      id: json['id'],
      differences: json['differences'],
    );
  }

  factory HistoryTypeUpdateDetails.fromDifferences(
      List<TaskDifference> differences) {
    return HistoryTypeUpdateDetails(differences: differences);
  }
}

class HistoryTypeDeleteDetails implements HistoryTypeDetails {
  @override
  final String id;

  final Task task;

  HistoryTypeDeleteDetails({String? id, required this.task})
      : id = id ?? DateTime.now().toString();

  @override
  String toJSON() {
    return jsonEncode({
      'id': id,
      'task': task.toJson(),
    });
  }

  factory HistoryTypeDeleteDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeDeleteDetails(
      id: json['id'],
      task: Task.fromJson(json['task']),
    );
  }

  factory HistoryTypeDeleteDetails.fromTask(Task task) {
    return HistoryTypeDeleteDetails(task: task);
  }
}
