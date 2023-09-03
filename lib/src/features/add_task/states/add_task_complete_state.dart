import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/models/task.dart';
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
    var task = mediator.taskBuilder.build();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(NewTaskAction(task));
    Navigator.pop(context);
  }
}