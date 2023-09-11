import 'package:do_something/src/features/models/task.dart';

abstract class TaskManager {
  final List<Task> tasks;

  TaskManager({
    required this.tasks,
  });

  Task? get currentTask;

  Task? get nextTask;

  void calcuateNextTask();

  void markDone();

  void updateAvailableTasks();

  TaskManager copyWith({List<Task>? newTasks});
}
