import 'package:do_something/src/features/task/task.dart';

abstract class TaskManager {
  final List<Task> tasks;

  TaskManager({
    required this.tasks,
  });

  Task? get currentTask;

  Task? get nextTask;

  void calcuateNextTask();

  TaskManager copyWith({List<Task>? newTasks});
}
