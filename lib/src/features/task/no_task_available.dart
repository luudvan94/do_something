import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class NoTaskAvailable extends StatelessWidget {
  final TaskColor taskColor;

  const NoTaskAvailable({Key? key, required this.taskColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container with background color and child type Center
    return Container(
      color: taskColor.background,
      child: Center(
        child: Text('No task available',
            style: AppTheme.textStyle(context).bodyMedium!),
      ),
    );
  }
}
