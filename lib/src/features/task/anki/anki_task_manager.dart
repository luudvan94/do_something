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
  }) {
    updateAvailableTasks();
  }

  List<Task> availableTasks = [];

  @override
  void updateAvailableTasks() {
    availableTasks = tasks.where((task) {
      return task.reviewDate.isBefore(DateTime.now()) &&
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
    if (currentTask == null) return;

    if (_isTaskFinished(currentTask!)) {
      updateAvailableTasks();
    } else {
      _moveToBack(availableTasks, currentTask);
    }
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
      var newReviewDate = DateTime.now().add(Duration(days: newInterval));

      logger.i('New review date: $newReviewDate');
      task.reviewDate = newReviewDate;
    }
  }

  @override
  AnkiTaskManager copyWith({List<Task>? newTasks}) {
    var copy = AnkiTaskManager(tasks: newTasks ?? tasks);
    // copy._updateAvailableTasks();
    return copy;
  }

  int byDateAndIgnoreCountLeft(Task a, Task b) {
    return a.reviewDate.compareTo(b.reviewDate);
  }

  void _moveToBack<T>(List<T> list, T element) {
    if (list.contains(element)) {
      list.remove(element);
      list.add(element);
    }
  }

  bool _isTaskFinished(Task task) {
    if ((task.isOneTimeDone && task.doneCount > 0) ||
        task.reviewDate.isBefore(DateTime.now()) == false) {
      return true;
    }

    return false;
  }
}
