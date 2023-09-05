import 'dart:convert';

import 'package:do_something/src/features/models/history_type.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_history.g.dart';

@HiveType(typeId: 1)
class TaskHistory<T extends HistoryTypeDetails> extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String taskId;

  @HiveField(2)
  DateTime doneDate;

  @HiveField(3)
  String typeString;

  @HiveField(4)
  String historyTypeId;

  @HiveField(5)
  String detailsJsonString;

  TaskHistory(
      {this.id = '',
      required this.taskId,
      required this.doneDate,
      required this.historyTypeId, //reference to history details id
      required this.typeString,
      required this.detailsJsonString}) {
    id = id.isEmpty ? DateTime.now().toString() : id;
  }

  HistoryType get type => HistoryTypeExtension.fromName(typeString);

  T get details {
    Map<String, dynamic> jsonMap = jsonDecode(detailsJsonString);
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

  @override
  String toString() {
    // print task history object
    return 'TaskHistory{id: $id, taskId: $taskId, doneDate: $doneDate, typeString: $typeString, historyId: $historyTypeId}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'doneDate': doneDate.toIso8601String(),
      'typeString': typeString,
      'historyId': historyTypeId,
      'detailsJsonString': detailsJsonString,
    };
  }

  static TaskHistory fromJson(Map<String, dynamic> json) {
    return TaskHistory(
      id: json['id'],
      taskId: json['taskId'],
      doneDate: DateTime.parse(json['doneDate']),
      typeString: json['typeString'],
      historyTypeId: json['historyId'],
      detailsJsonString: json['detailsJsonString'],
    );
  }
}
