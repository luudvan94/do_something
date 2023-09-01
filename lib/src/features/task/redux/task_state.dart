import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';

class TaskState {
  final List<Task> tasks;
  // add currentTask, nextTask

  Task? get currentTask => null;
  Task? get nextTask => null;

  TaskState({required this.tasks});

  // add copyWith function
  TaskState copyWith({
    List<Task>? tasks,
    Task? currentTask,
    Task? nextTask,
  }) {
    var copy = TaskState(
      tasks: tasks ?? this.tasks,
    );

    return copy;
  }
}

var tasksKey = 'tasksKey';
var currentTaskIdKey = 'currentTaskIdKey';
TaskState loadTaskState(Box box) {
  logger.i('Loading task from Hive');
  var tasks = box.get(tasksKey, defaultValue: []) as List<Task>;

  return TaskState(tasks: tasks);
}
