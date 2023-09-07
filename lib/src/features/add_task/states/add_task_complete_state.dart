import 'package:do_something/src/features/add_task/builder/task_builder.dart';
import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/rating.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddTaskCompleteState extends AddTaskBaseState {
  @override
  void apply(AddTaskMediator mediator) {
    logger.i('AddTaskCompleteState.apply');
  }

  @override
  void onGoBack(BuildContext context, AddTaskMediator mediator) {
    logger.i('AddTaskCompleteState.onGoBack');
    mediator.transitionToPreviousState();
  }

  @override
  void onGoNext(BuildContext context, AddTaskMediator mediator) {
    logger.i('AddTaskCompleteState.onGoNext');

    if (mediator.taskBuilder.task == null) {
      _addNewTask(context, mediator);
    } else {
      _updateTask(context, mediator);
    }

    Navigator.pop(context);
  }

  void _addNewTask(BuildContext context, AddTaskMediator mediator) {
    var task = mediator.taskBuilder.build();
    var taskHistory = TaskHistory.create(task);

    logger.i('Task: $task, Task history: $taskHistory');
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(NewTaskAction(task));
    store.dispatch(AddTaskHistoryAction(taskHistory));
  }

  void _updateTask(BuildContext context, AddTaskMediator mediator) {
    var task = mediator.taskBuilder.task;

    if (task == null) {
      logger.e('Task is null');
      return;
    }

    var taskHistory =
        TaskHistory.update(task, _buildDifferences(task, mediator.taskBuilder));

    var updatedTask = mediator.taskBuilder.build();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateTaskAction(updatedTask));
    store.dispatch(AddTaskHistoryAction(taskHistory));
  }

  List<TaskDifference> _buildDifferences(Task task, TaskBuilder taskBuilder) {
    List<TaskDifference> differences = [];
    if (taskBuilder.name != null && task.name != taskBuilder.name) {
      differences.add(TaskDifference(task.name, taskBuilder.name!));
    }

    if (task.details != taskBuilder.details) {
      differences.add(TaskDifference(task.details, taskBuilder.details));
    }

    if (taskBuilder.rating != null &&
        task.rating != taskBuilder.rating!.toName()) {
      differences
          .add(TaskDifference(task.rating, taskBuilder.rating!.toName()));
    }

    if (taskBuilder.isOneTimeDone != null &&
        task.isOneTimeDone != taskBuilder.isOneTimeDone) {
      differences.add(TaskDifference(
          task.isOneTimeDone ? 'One time done' : 'Recurring',
          taskBuilder.isOneTimeDone! ? 'One time done' : 'Recurring'));
    }

    return differences;
  }
}
