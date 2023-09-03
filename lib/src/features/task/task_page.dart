import 'dart:math';

import 'package:do_something/src/features/task/footer.dart';
import 'package:do_something/src/features/task/header.dart';
import 'package:do_something/src/features/task/not_dragging_task_container.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/features/task/task_container.dart';
import 'package:do_something/src/redux/init_redux.dart';
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
          return Scaffold(
            body: Stack(
              children: [
                // NotDraggingTaskContainer
                taskState.nextTask != null
                    ? NotDraggingTaskContainer(task: taskState.nextTask!)
                    : const SizedBox.shrink(),

                // TaskContainer
                taskState.currentTask != null
                    ? TaskContainer(
                        task: taskState.currentTask!,
                        onHalfWidthReached: () {
                          _handleHalfWidthReached();
                        })
                    : const SizedBox.shrink(),

                // Header at the top of the screen
                SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Header(
                            task: taskState.currentTask,
                          ),
                        ),
                        taskState.currentTask != null
                            ? Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Footer(task: taskState.currentTask!))
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
