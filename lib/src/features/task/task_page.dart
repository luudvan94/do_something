import 'dart:math';

import 'package:do_something/src/features/task/not_dragging_task_container.dart';
import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/features/task/task_container.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:flutter/material.dart';

// mock task array with different ratings, and long name
List<Task> tasks = [
  Task(
    id: '1',
    name: 'Very Bad Task',
    rating: Rating.veryBad,
  ),
  Task(
    id: '2',
    name: 'Bad Task',
    rating: Rating.bad,
  ),
  Task(
    id: '3',
    name: 'Neutral Task',
    rating: Rating.neutral,
  ),
  Task(
    id: '4',
    name: 'Good Task',
    rating: Rating.good,
  ),
  Task(
    id: '5',
    name: 'Very Good Task',
    rating: Rating.veryGood,
  ),
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
              })
        ],
      ),
    );
  }
}
