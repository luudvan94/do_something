import 'package:do_something/src/features/task/anki/anki_task_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/rating.dart';

void main() {
  group('AnkiTaskManager', () {
    late AnkiTaskManager manager;

    setUp(() {
      manager = AnkiTaskManager(tasks: [
        Task(
            name: 'Task 1',
            reviewDate: DateTime.now().subtract(const Duration(days: 1)),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false),
        Task(
            name: 'Task 2',
            reviewDate: DateTime.now().add(const Duration(days: 1)),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false),
      ]);
    });

    test('should calculate available tasks correctly', () {
      expect(manager.availableTasks.length, 1);
    });

    test('should get current task correctly', () {
      expect(manager.currentTask?.name, 'Task 1');
    });

    test('should mark task as done correctly', () {
      manager.markDone();
      expect(manager.availableTasks.length, 0);
    });

    test(
        'should calculate next task correctly when the currentTask still has ignore count left',
        () {
      manager.calcuateNextTask();
      expect(manager.currentTask?.name, 'Task 1');
    });

    test('should not include one-time done tasks in available tasks', () {
      manager.markDone(); // Assuming this sets a task as one-time done
      expect(manager.availableTasks.where((task) => task.isOneTimeDone).isEmpty,
          true);
    });

    test('should remove task with zero ignore count from available tasks', () {
      manager
          .calcuateNextTask(); // Assuming this sets ignoreCountLeft to zero for a task
      expect(
          manager.availableTasks
              .where((task) => task.ignoreCountLeft <= 0)
              .isEmpty,
          true);
    });

    test('should have empty available tasks when all tasks are in the future',
        () {
      manager = AnkiTaskManager(tasks: [
        Task(
            name: 'Future Task',
            reviewDate: DateTime.now().add(Duration(days: 1)),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false),
      ]);
      expect(manager.availableTasks.isEmpty, true);
    });

    test('should create a new instance with updated tasks using copyWith', () {
      var newManager = manager.copyWith(newTasks: [
        Task(
            name: 'New Task',
            reviewDate: DateTime.now(),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false),
      ]);
      expect(newManager.tasks.length, 1);
      expect(newManager.tasks[0].name, 'New Task');
    });
  });

  group('AnkiTaskManager Sorting', () {
    late AnkiTaskManager manager;

    setUp(() {
      manager = AnkiTaskManager(tasks: [
        Task(
            name: 'Task 1',
            reviewDate: DateTime.now().subtract(Duration(days: 1)),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false,
            ignoreCountLeft: 1),
        Task(
            name: 'Task 2',
            reviewDate: DateTime.now().subtract(Duration(days: 1)),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false,
            ignoreCountLeft: 2),
        Task(
            name: 'Task 3',
            reviewDate: DateTime.now().subtract(Duration(days: 2)),
            doneCount: 0,
            rating: Rating.neutral.toName(),
            isOneTimeDone: false,
            ignoreCountLeft: 1),
      ]);
    });

    test('should sort tasks correctly', () {
      expect(manager.tasks[0].name, 'Task 3');
      expect(manager.tasks[1].name, 'Task 2');
      expect(manager.tasks[2].name, 'Task 1');
    });
  });
}
