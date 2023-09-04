import 'dart:math';

import 'package:do_something/src/features/task/footer.dart';
import 'package:do_something/src/features/task/header.dart';
import 'package:do_something/src/features/task/no_task_available.dart';
import 'package:do_something/src/features/task/not_dragging_task_container.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/features/task/task_container.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
  }

  void _handleHalfWidthReached() {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(NextTaskAction(store.state.taskState.currentTask!));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskState>(
        converter: (store) => store.state.taskState,
        builder: (context, taskState) {
          var currentTask = taskState.currentTask;
          var nextTask = taskState.nextTask;
          var currentTaskColor = TaskColorSet.set1;

          return Scaffold(
            backgroundColor: AppTheme.appColors(context).background,
            body: Stack(
              children: [
                nextTask == null && currentTask == null
                    ? NoTaskAvailable(taskColor: AppTheme.appTaskColor(context))
                    : const SizedBox.shrink(),

                // NotDraggingTaskContainer
                nextTask != null
                    ? NotDraggingTaskContainer(
                        task: nextTask,
                        taskColor: currentTaskColor
                            .colorFromRating(nextTask.ratingEnum),
                      )
                    : const SizedBox.shrink(),

                // TaskContainer
                currentTask != null
                    ? TaskContainer(
                        task: currentTask,
                        taskColor: currentTaskColor
                            .colorFromRating(currentTask.ratingEnum),
                        onHalfWidthReached: () {
                          _handleHalfWidthReached();
                        })
                    : const SizedBox.shrink(),

                // Header at the top of the screen
                SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Header(
                          task: currentTask,
                          taskColor: currentTask != null
                              ? currentTaskColor
                                  .colorFromRating(currentTask.ratingEnum)
                              : AppTheme.appTaskColor(context),
                        ),
                        currentTask != null
                            ? Footer(
                                task: currentTask,
                                taskColor: currentTaskColor
                                    .colorFromRating(currentTask.ratingEnum),
                              )
                            : const SizedBox.shrink(),
                      ]),
                )

                // Footer at bottom of the screen
              ],
            ),
          );
        });
  }
}
