import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_reducer.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/mock/task_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return new state when NewTaskAction is triggered', () {
    // create state
    var mockState = mockTaskState;
    // create NewTaskAction
    var mockTask = Task(
        name: 'Task 4',
        rating: Rating.neutral.toName(),
        doneCount: 0,
        reviewDate: DateTime.now());

    var action = NewTaskAction(mockTask);
    // call reducer
    var newState = taskStateReduce(mockState, action);
    // expect new state
    expect(newState.tasks.length, 4);
  });

  test('should return new state when DeleteTaskAction is triggered', () {
    // create state
    var mockState = mockTaskState;
    // create DeleteTaskAction
    var mockTask = mockState.tasks[0];

    var action = DeleteTaskAction(mockTask);
    // call reducer
    var newState = taskStateReduce(mockState, action);
    // expect new state
    expect(newState.tasks.length, 2);
  });

  test('should return new state when UpdateTaskAction is triggered', () {
    // create state
    var mockState = mockTaskState;
    // create UpdateTaskAction
    var mockTask = mockState.tasks[0];
    mockTask.name = 'Task 1 Updated';

    var action = UpdateTaskAction(mockTask);
    // call reducer
    var newState = taskStateReduce(mockState, action);
    // expect new state
    expect(newState.tasks[0].name, 'Task 1 Updated');
  });
}
