import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/rating.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';

var mockTask = TaskExtension.fromName('test1', Rating.neutral);
var mockDifferences = [
  TaskDifference('old name', 'new name'),
  TaskDifference(Rating.bad.toName(), Rating.good.toName()),
];

TaskHistoryState mockTaskHistoryState =
    TaskHistoryState(taskId: 'test1', histories: [
  TaskHistory.create(mockTask),
  TaskHistory.complete(
      mockTask, 'kinda functional', DateTime.now(), DateTime.now()),
  TaskHistory.update(mockTask, mockDifferences),
  TaskHistory.delete(mockTask)
]);
