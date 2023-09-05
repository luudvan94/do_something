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
  dynamic oldValue;
  dynamic newValue;
}

abstract class HistoryTypeDetails {
  final String id;

  HistoryTypeDetails({String? id}) : id = id ?? DateTime.now().toString();

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
    };
  }
}

class HistoryTypeCompleteDetails implements HistoryTypeDetails {
  @override
  final String id;

  final String? comment;

  HistoryTypeCompleteDetails({required this.id, this.comment});

  @override
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'comment': comment,
    };
  }

  factory HistoryTypeCompleteDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeCompleteDetails(
      id: json['id'],
      comment: json['comment'],
    );
  }
}

class HistoryTypeCreateDetails implements HistoryTypeDetails {
  @override
  final String id;

  final Task task;

  HistoryTypeCreateDetails({required this.id, required this.task});

  @override
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'task': task.toJson(),
    };
  }

  factory HistoryTypeCreateDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeCreateDetails(
      id: json['id'],
      task: Task.fromJson(json['task']),
    );
  }
}

class HistoryTypeUpdateDetails implements HistoryTypeDetails {
  @override
  final String id;

  final List<TaskDifference> differences;

  HistoryTypeUpdateDetails({required this.id, required this.differences});

  @override
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'differences': differences,
    };
  }

  factory HistoryTypeUpdateDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeUpdateDetails(
      id: json['id'],
      differences: json['differences'],
    );
  }
}

class HistoryTypeDeleteDetails implements HistoryTypeDetails {
  @override
  final String id;

  final Task task;

  HistoryTypeDeleteDetails({required this.id, required this.task});

  @override
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'task': task.toJson(),
    };
  }

  factory HistoryTypeDeleteDetails.fromJson(Map<String, dynamic> json) {
    return HistoryTypeDeleteDetails(
      id: json['id'],
      task: Task.fromJson(json['task']),
    );
  }
}
