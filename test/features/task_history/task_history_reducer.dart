import 'dart:convert';

import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_reducer.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockBox extends Mock implements Box {}

void main() {
  group('group name', () {
    test('should handle AddTaskHistoryAction', () {
      final initialState = TaskHistoryState(histories: []);
      final newHistory = TaskHistory(
          taskId: 'test1',
          doneDate: DateTime.now(),
          typeString: 'some_type',
          details: HistoryTypeUpdateDetails(differences: []));
      final action = AddTaskHistoryAction(newHistory);

      final newState = taskHistoryReducer(initialState, action);

      expect(newState.histories.length, 1);
      expect(newState.histories[0], newHistory);
    });

    test('should handle LoadHistoriesAction', () {
      // Arrange
      final initialState = TaskHistoryState(histories: []);
      final action = LoadHistoriesAction('some_task_id');
      final mockBox = MockBox();
      final loadedHistory = TaskHistory(
        taskId: 'some_task_id',
        doneDate: DateTime.now(),
        typeString: 'some_type',
        details: HistoryTypeUpdateDetails(differences: []),
      );

      when(mockBox.get(any, defaultValue: anyNamed('defaultValue')))
          .thenReturn([
        loadedHistory.toJson(),
      ]);

      // Act
      final newState = loadHistoriesHandler(
        initialState,
        action,
        (_) => mockBox, // Pass the mockBox here
      );

      // Assert
      expect(newState.histories.length, 1);
    });
  });
}
