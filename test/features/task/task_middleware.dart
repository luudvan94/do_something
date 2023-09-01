import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_middleware.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/mock/mock_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTaskSaver extends Mock implements TaskSaver {}

class MockFunction extends Mock {
  dynamic call(dynamic action);
}

void main() {
  final mockTaskSaver = MockTaskSaver();
  final store = MockStore();

  // Mock saveTasks to do nothing (or any mock behavior you want)
  when(mockTaskSaver.saveTasks(store)).thenReturn(null);

  group('Middleware Tests', () {
    test('should call next action in saveTaskMiddleware', () async {
      var action = NewTaskAction(Task(
          name: 'Task 4',
          rating: Rating.neutral.toName(),
          doneCount: 0,
          reviewDate: DateTime.now()));

      // Create mock function for next dispatcher
      final next = MockFunction();

      // Inject the mock into middleware
      await saveTaskMiddleware(mockTaskSaver)(store, action, next);

      // Verify that next was called with NewTaskAction
      verify(next(captureThat(isA<NewTaskAction>()))).called(1);

      // Verify that mockTaskSaver.saveTasks was called
      verify(mockTaskSaver.saveTasks(store)).called(1);
    });
  });
}
