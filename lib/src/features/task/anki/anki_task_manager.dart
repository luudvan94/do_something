import 'package:do_something/src/features/task/anki/task_manager.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/utils/logger.dart';

class AnkiTaskManager implements TaskManager {
  @override
  final List<Task> tasks;

  int _currentTaskIndex = 0;

  AnkiTaskManager({
    required this.tasks,
  });

  @override
  Task? get currentTask {
    if (_currentTaskIndex >= 0 && _currentTaskIndex < tasks.length) {
      return tasks[_currentTaskIndex];
    }
    return null;
  }

  @override
  Task? get nextTask {
    int nextIndex = _currentTaskIndex + 1;
    if (nextIndex >= 0 && nextIndex < tasks.length) {
      return tasks[nextIndex];
    }
    return null;
  }

  @override
  void calcuateNextTask() {
    logger.i('AnkiTaskManager.calcuateNextTask');
    _currentTaskIndex += 1;
  }

  @override
  AnkiTaskManager copyWith({List<Task>? newTasks}) {
    return AnkiTaskManager(tasks: newTasks ?? tasks);
  }
}
