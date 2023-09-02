import 'dart:math';

import 'package:do_something/src/features/task/footer.dart';
import 'package:do_something/src/features/task/header.dart';
import 'package:do_something/src/features/task/not_dragging_task_container.dart';
import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/features/task/task_container.dart';
import 'package:flutter/material.dart';

// mock task array with different ratings, and long name
final tasks = [
  TaskExtension.fromName('Task 1', Rating.neutral),
  TaskExtension.fromName('Task 2', Rating.bad),
  TaskExtension.fromName('Task 3', Rating.good),
  TaskExtension.fromName('Task 4', Rating.veryBad),
  TaskExtension.fromName('Task 5', Rating.veryGood),
];

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Task currentTask;
  late Task nextTask;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentTask = tasks[currentIndex];
    nextTask = tasks[currentIndex + 1];
  }

  void _handleHalfWidthReached() {
    setState(() {
      // Remove the task that reached half width

      if (currentIndex == tasks.length - 1) {
        currentIndex = 0;
      } else {
        currentIndex++;
      }

      currentTask = nextTask;
      nextTask = tasks[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotDraggingTaskContainer(task: nextTask),
          TaskContainer(
              task: currentTask,
              onHalfWidthReached: () {
                _handleHalfWidthReached();
              }),
          // Header at the top of the screen
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
                child: Header(
              task: currentTask,
            )),
          ),
          // Footer at bottom of the screen
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Footer(task: currentTask),
          ),
        ],
      ),
    );
  }
}
