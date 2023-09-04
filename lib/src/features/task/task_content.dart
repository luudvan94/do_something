import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class TaskContent extends StatelessWidget {
  final Task task;
  final TaskColor taskColor;

  const TaskContent({Key? key, required this.task, required this.taskColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        task.name,
        style: AppTheme.textStyle(context).bodyLarge!.copyWith(
              color: taskColor.foreground,
            ),
      ),
    );
  }
}
