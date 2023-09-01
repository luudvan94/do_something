import 'package:do_something/src/features/task_history/redux/task_history.dart';

class TaskHistoryAction {
  TaskHistory history;

  TaskHistoryAction(this.history);
}

class AddTaskHistoryAction extends TaskHistoryAction {
  AddTaskHistoryAction(TaskHistory history) : super(history);
}
