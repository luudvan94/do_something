import 'package:do_something/src/features/task/anki/anki_task_manager.dart';
import 'package:do_something/src/features/task/anki/task_manager.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/utils/date.dart';
import 'package:do_something/src/utils/hive.dart';
import 'package:do_something/src/utils/logger.dart';

class TaskState {
  final List<Task> tasks;
  final TaskManager taskManager;
  final DateTime lastCheckedInDate;
  final int doneTimes;

  Task? get currentTask {
    return taskManager.currentTask;
  }

  Task? get nextTask {
    return taskManager.nextTask;
  }

  TaskState({
    required this.tasks,
    required this.taskManager,
    required this.lastCheckedInDate,
    this.doneTimes = 0,
  });

  // Add copyWith function
  TaskState copyWith({
    List<Task>? tasks,
    TaskManager? taskManager,
    int doneTimes = 0,
  }) {
    return TaskState(
      doneTimes: doneTimes,
      lastCheckedInDate: lastCheckedInDate,
      tasks: tasks ?? this.tasks,
      taskManager: taskManager ??
          this.taskManager.copyWith(newTasks: tasks ?? this.tasks),
    );
  }
}

var tasksKey = 'tasksKey';
var currentTaskIdKey = 'currentTaskIdKey';
var checkInDateKey = 'checkInDateKey';
var doneTimes = 'doneTimesKey';

Future<TaskState> loadTaskState(String boxName) async {
  logger.i('Loading task from Hive');
  var box = await openBox(boxName);
  var dynamicList = box.get(tasksKey, defaultValue: []) as List;
  var tasks = dynamicList.cast<Task>();

  var latestCheckedInDate =
      box.get(checkInDateKey, defaultValue: DateTime.now());
  var numberOfDoneTimes = box.get(doneTimes, defaultValue: 0);

  //TODO: just for testing, the condition should be !isSameDate(latestCheckedInDate, DateTime.now())
  if (isSameDate(latestCheckedInDate, DateTime.now())) {
    logger.i('Resetting ignoreCount of each task to default of 3');
    tasks.forEach((task) {
      task.ignoreCountLeft = 3;
    });
    box.put(checkInDateKey, DateTime.now());
  }
  return TaskState(
      tasks: tasks,
      lastCheckedInDate: latestCheckedInDate,
      doneTimes: numberOfDoneTimes,
      taskManager: AnkiTaskManager(tasks: tasks));
}
