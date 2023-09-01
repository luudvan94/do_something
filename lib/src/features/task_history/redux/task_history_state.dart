import 'package:do_something/src/features/task_history/redux/task_history.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';

var taskHistoryStateKeyBox = 'taskHistoryStateKeyBox';

class TaskHistoryState {
  List<TaskHistory> histories;

  TaskHistoryState({required this.histories});

  List<TaskHistory> findHistoriesByTaskId(String taskId) {
    return histories.where((history) => history.taskId == taskId).toList();
  }

  // add copyWith function
  TaskHistoryState copyWith({
    List<TaskHistory>? histories,
  }) {
    var copy = TaskHistoryState(
      histories: histories ?? this.histories,
    );

    return copy;
  }
}

var defaultTaskHistoryState = TaskHistoryState(histories: []);
var taskHistoryKey = 'taskHistoryKey';
TaskHistoryState loadTaskHistoryState(Box box) {
  logger.i('Loading task history from Hive');
  var dynamic = box.get(taskHistoryKey, defaultValue: []) as List;
  var histories = dynamic.cast<TaskHistory>();
  return TaskHistoryState(histories: histories);
}
