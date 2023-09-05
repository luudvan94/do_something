import 'package:do_something/src/features/task/anki/task_manager.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/rating.dart';
import 'package:do_something/src/utils/anki.dart';
import 'package:do_something/src/utils/logger.dart';

class AnkiTaskManager implements TaskManager {
  @override
  final List<Task> tasks;

  AnkiTaskManager({
    required this.tasks,
  });

  List<Task> get availableTasks {
    return tasks.where((task) {
      return task.reviewDate.isBefore(DateTime.now()) &&
          task.ignoreCountLeft > 0 &&
          !(task.isOneTimeDone && task.doneCount > 0);
    }).toList()
      ..sort(byDateAndIgnoreCountLeft);
  }

  @override
  Task? get currentTask {
    if (availableTasks.isEmpty) return null;
    return availableTasks[0];
  }

  @override
  Task? get nextTask {
    if (availableTasks.isEmpty || availableTasks.length < 2) return null;
    return availableTasks[1];
  }

  @override
  void calcuateNextTask() {
    // Decrement the ignoreCountLeft of the current task
    currentTask?.ignoreCountLeft -= 1;
    logger.i('AnkiTaskManager.calcuateNextTask: $currentTask');
  }

  @override
  void markDone() {
    logger.i('AnkiTaskManager.markDone');
    Task? task = currentTask;
    if (task != null) {
      task.doneCount += 1;

      if (task.isOneTimeDone && task.doneCount > 0) {
        return;
      }

      // Calculate new review date using the Anki algorithm function
      int newInterval =
          calculateAnkiInterval(task.doneCount, task.ratingEnum.difficulty());
      task.reviewDate = DateTime.now().add(Duration(days: newInterval));
    }
  }

  @override
  AnkiTaskManager copyWith({List<Task>? newTasks}) {
    return AnkiTaskManager(tasks: newTasks ?? tasks);
  }

  int byDateAndIgnoreCountLeft(Task a, Task b) {
    DateTime dateA =
        DateTime(a.reviewDate.year, a.reviewDate.month, a.reviewDate.day);
    DateTime dateB =
        DateTime(b.reviewDate.year, b.reviewDate.month, b.reviewDate.day);

    int dateComparison = dateA.compareTo(dateB);
    if (dateComparison != 0) {
      return dateComparison;
    }
    return b.ignoreCountLeft.compareTo(a.ignoreCountLeft);
  }
}
