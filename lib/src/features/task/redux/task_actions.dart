import 'package:do_something/src/features/models/task.dart';

class TaskAction {
  final Task task;

  TaskAction(this.task);
}

class NewTaskAction extends TaskAction {
  NewTaskAction(Task task) : super(task);
}

// create delete action
class DeleteTaskAction extends TaskAction {
  DeleteTaskAction(Task task) : super(task);
}

// create update action
class UpdateTaskAction extends TaskAction {
  UpdateTaskAction(Task task) : super(task);
}

class NextTaskAction extends TaskAction {
  NextTaskAction(Task task) : super(task);
}

class MarkTaskDoneAction extends TaskAction {
  MarkTaskDoneAction(Task task) : super(task);
}
