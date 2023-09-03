import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:flutter/material.dart';

abstract class AddTaskBaseState {
  void apply(AddTaskMediator mediator);
  void onGoBack(BuildContext context, AddTaskMediator mediator);
  void onGoNext(BuildContext context, AddTaskMediator mediator);
}
