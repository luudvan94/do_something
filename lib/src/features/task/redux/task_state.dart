import 'package:do_something/src/features/task/anki/anki_task_manager.dart';
import 'package:do_something/src/features/task/anki/task_manager.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:do_something/src/utils/date.dart';
import 'package:do_something/src/utils/hive.dart';
import 'package:do_something/src/utils/logger.dart';

class TaskState {
  final List<Task> tasks;
  final TaskManager taskManager;
  final DateTime lastCheckedInDate;
  final String selectedColorSetId;
  final int doneTimes;

  Task? get currentTask {
    return taskManager.currentTask;
  }

  Task? get nextTask {
    return taskManager.nextTask;
  }

  TaskState(
      {required this.tasks,
      required this.taskManager,
      required this.lastCheckedInDate,
      this.doneTimes = 0,
      this.selectedColorSetId = 'set1'});

  // Add copyWith function
  TaskState copyWith({
    List<Task>? tasks,
    TaskManager? taskManager,
    int doneTimes = 0,
    String? selectedColorSetId,
  }) {
    return TaskState(
      selectedColorSetId: selectedColorSetId ?? this.selectedColorSetId,
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
var doneTimesKey = 'doneTimesKey';
var selectedColorSetKey = 'selectedColorSetKey';

Future<TaskState> loadTaskState(String boxName) async {
  logger.i('Loading task from Hive');
  var box = await openBox(boxName);
  var dynamicList = box.get(tasksKey, defaultValue: []) as List;
  var tasks = dynamicList.cast<Task>();

  var latestCheckedInDate =
      box.get(checkInDateKey, defaultValue: DateTime.now());
  var numberOfDoneTimes = box.get(doneTimesKey, defaultValue: 0);
  var selectedColorSetId =
      box.get(selectedColorSetKey, defaultValue: TaskColorSet.set1.id);

  // if (!isSameDate(latestCheckedInDate, DateTime.now())) {
  //   logger.i('Resetting ignoreCount of each task to default of 3');
  //   tasks.forEach((task) {
  //     task.ignoreCountLeft = 3;
  //   });
  //   box.put(checkInDateKey, DateTime.now());
  // }
  return TaskState(
      selectedColorSetId: selectedColorSetId,
      tasks: tasks,
      lastCheckedInDate: latestCheckedInDate,
      doneTimes: numberOfDoneTimes,
      taskManager: AnkiTaskManager(tasks: tasks));
}
