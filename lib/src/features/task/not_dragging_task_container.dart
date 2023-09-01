import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:do_something/src/features/task/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotDraggingTaskContainer extends StatefulWidget {
  Task task;

  NotDraggingTaskContainer({Key? key, required this.task}) : super(key: key);

  @override
  State<NotDraggingTaskContainer> createState() =>
      _NotDraggingTaskContainerState();
}

class _NotDraggingTaskContainerState extends State<NotDraggingTaskContainer> {
  @override
  Widget build(BuildContext context) {
    // container with background color and child type TaskContent
    return Container(
      color: widget.task.rating.getColorFromTheme(context),
      child: TaskContent(
        task: widget.task,
      ),
    );
  }
}
