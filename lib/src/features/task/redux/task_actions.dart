import 'package:do_something/src/features/task/task.dart';

class TaskAction {
  final Task task;

  TaskAction(this.task);
}

class NonTaskAction {}

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

class UpdateNextTaskAction extends NonTaskAction {}
