import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class NotDraggingTaskContainer extends StatefulWidget {
  final Task task;
  final TaskColor taskColor;

  const NotDraggingTaskContainer(
      {Key? key, required this.task, required this.taskColor})
      : super(key: key);

  @override
  State<NotDraggingTaskContainer> createState() =>
      _NotDraggingTaskContainerState();
}

class _NotDraggingTaskContainerState extends State<NotDraggingTaskContainer> {
  @override
  Widget build(BuildContext context) {
    // container with background color and child type TaskContent
    return Container(
      color: widget.taskColor.background,
      child: TaskContent(
        task: widget.task,
        taskColor: widget.taskColor,
      ),
    );
  }
}
