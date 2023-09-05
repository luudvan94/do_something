import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_middleware.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockBox extends Mock implements Box {}

class MockTaskHistorySaver extends Mock implements TaskHistorySaver {
  final CallbackAction mockGetBox;

  MockTaskHistorySaver(this.mockGetBox) : super();

  @override
  void saveHistories(Store<AppState> store, String taskId) {
    super.noSuchMethod(
      Invocation.method(#saveHistories, [store, taskId]),
    );
  }
}

class MockFunction extends Mock {
  dynamic call(dynamic action);
}

class MockStore extends Mock implements Store<AppState> {}

void main() {
  group('TaskHistoryMiddleware Tests', () {
    test('should call next action in saveTaskHistoryMiddleware', () async {
      var action = AddTaskHistoryAction(TaskHistory(
          taskId: 'some_task_id',
          doneDate: DateTime.now(),
          historyTypeId: 'typeId',
          typeString: 'some_type',
          detailsJsonString: 'detailsJsonString'));

      // Create mock function for next dispatcher
      final next = MockFunction();
      final mockBox = MockBox();

      // Inject the mock into middleware
      final mockTaskHistorySaver = MockTaskHistorySaver((_) => mockBox);
      final store = MockStore();

      await saveTaskHistoryMiddleware(mockTaskHistorySaver)(
          store, action, next);

      // Verify that next was called with AddTaskHistoryAction
      verify(next(captureThat(isA<AddTaskHistoryAction>()))).called(1);

      // Verify that mockTaskHistorySaver.saveHistories was called
      verify(mockTaskHistorySaver.saveHistories(store, 'some_task_id'))
          .called(1);
    });
  });
}
