import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class NoTaskAvailable extends StatelessWidget {
  final TaskColor taskColor;

  const NoTaskAvailable({Key? key, required this.taskColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container with background color and child type Center
    return StoreConnector<AppState, TaskState>(
        converter: (store) => store.state.taskState,
        builder: (context, taskState) {
          return Container(
              color: taskColor.background,
              child: Center(
                child: Text('No task available',
                    style: AppTheme.textStyle(context).bodyMedium!),
              ));
        });
  }
}
