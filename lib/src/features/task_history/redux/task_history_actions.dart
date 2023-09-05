import 'package:do_something/src/features/models/task_history.dart';

class TaskHistoryAction {
  TaskHistory history;

  TaskHistoryAction(this.history);
}

class AddTaskHistoryAction extends TaskHistoryAction {
  AddTaskHistoryAction(TaskHistory history) : super(history);
}

class LoadHistoriesAction {
  final String taskId;

  LoadHistoriesAction(this.taskId);
}
