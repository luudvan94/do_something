import 'package:do_something/src/features/add_task/builder/task_builder.dart';
import 'package:flutter/material.dart';

abstract class AddTaskMediator {
  late TaskBuilder taskBuilder;

  void transitionToNextState();
  void transitionToPreviousState();
  void setChildWidget(Widget childWidget);
}
