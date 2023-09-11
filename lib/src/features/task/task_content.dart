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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTaskName(context),
          const SizedBox(height: 20),
          task.details != ''
              ? _buildTaskDescription(context)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildTaskName(BuildContext context) {
    return Text(
      task.name,
      style: AppTheme.textStyle(context).bodyLarge!.copyWith(
            color: taskColor.foreground,
          ),
    );
  }

  Widget _buildTaskDescription(BuildContext context) {
    return Text(
      task.details,
      style: AppTheme.textStyle(context).bodyMedium!.copyWith(
            color: taskColor.foreground,
          ),
    );
  }
}
