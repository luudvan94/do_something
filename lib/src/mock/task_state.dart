// create mock task state
import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/features/task/task.dart';

TaskState mockTaskState = TaskState(
  tasks: [
    // create mock tasks
    Task(
        name: 'Task 1',
        rating: Rating.neutral.toName(),
        doneCount: 0,
        reviewDate: DateTime.now()),
    Task(
        name: 'Task 2',
        rating: Rating.neutral.toName(),
        doneCount: 0,
        reviewDate: DateTime.now()),
    Task(
        name: 'Task 3',
        rating: Rating.neutral.toName(),
        doneCount: 0,
        reviewDate: DateTime.now()),
  ],
);
