import 'package:do_something/src/features/task/anki/anki_task_manager.dart';
import 'package:do_something/src/features/task/anki/task_manager.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/utils/date.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';

class TaskState {
  final List<Task> tasks;
  final TaskManager taskManager;

  Task? get currentTask {
    return taskManager.currentTask;
  }

  Task? get nextTask {
    return taskManager.nextTask;
  }

  TaskState({
    required this.tasks,
    TaskManager? taskManager,
  }) : taskManager = taskManager ?? AnkiTaskManager(tasks: tasks);

  // Add copyWith function
  TaskState copyWith({
    List<Task>? tasks,
    TaskManager? taskManager,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      taskManager: taskManager ??
          this.taskManager.copyWith(newTasks: tasks ?? this.tasks),
    );
  }
}

var tasksKey = 'tasksKey';
var currentTaskIdKey = 'currentTaskIdKey';
var checkInDateKey = 'checkInDateKey';

TaskState loadTaskState(Box box) {
  logger.i('Loading task from Hive');
  var dynamicList = box.get(tasksKey, defaultValue: []) as List;
  var tasks = dynamicList.cast<Task>();

  var latestCheckedInDate =
      box.get(checkInDateKey, defaultValue: DateTime.now());

  if (isSameDate(latestCheckedInDate, DateTime.now())) {
    logger.i('Resetting ignoreCount of each task to default of 3');
    tasks.forEach((task) {
      task.ignoreCountLeft = 2;
    });
    box.put(checkInDateKey, DateTime.now());
  }
  return TaskState(tasks: tasks);
}
