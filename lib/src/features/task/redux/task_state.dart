import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';

var taskStateKeyBox = 'taskStateKeyBox';

class TaskState {
  final List<Task> tasks;
  // add currentTask, nextTask
  late Task currentTask;
  late Task nextTask;

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
    copy.currentTask = currentTask ?? this.currentTask;
    copy.nextTask = nextTask ?? this.nextTask;

    return copy;
  }
}

var defaultTaskState = TaskState(tasks: []);

TaskState loadTaskState(Box box) {
  logger.i('Loading task from Hive');
  return box.get(taskStateKeyBox, defaultValue: defaultTaskState);
}
