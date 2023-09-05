import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/utils/hive.dart';
import 'package:hive/hive.dart';

var taskHistoryStateKeyBox = 'taskHistoryStateKeyBox';

class TaskHistoryState {
  final String? taskId;
  List<TaskHistory> histories;

  TaskHistoryState({
    required this.histories,
    this.taskId,
  });

  List<TaskHistory> findHistoriesByTaskId(String taskId) {
    return histories.where((history) => history.taskId == taskId).toList();
  }

  // add copyWith function
  TaskHistoryState copyWith({
    String? taskId,
    List<TaskHistory>? histories,
  }) {
    var copy = TaskHistoryState(
      taskId: taskId,
      histories: histories ?? this.histories,
    );

    return copy;
  }
}

var defaultTaskHistoryState = TaskHistoryState(histories: []);

Future<TaskHistoryState> loadTaskHistoryState(String boxName) async {
  await openBox(boxName);
  //we're gonna load history datas on user's request
  return defaultTaskHistoryState;
}
