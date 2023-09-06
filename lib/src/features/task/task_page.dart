import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/footer.dart';
import 'package:do_something/src/features/task/header.dart';
import 'package:do_something/src/features/task/no_task_available.dart';
import 'package:do_something/src/features/task/not_dragging_task_container.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/features/task/task_container.dart';
import 'package:do_something/src/features/task_history/task_history_page.dart';
import 'package:do_something/src/mixings/scaling_mixing.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with TickerProviderStateMixin, ScalingMixin<TaskPage> {
  @override
  void initState() {
    super.initState();
    initScaling(1.0, 0.85, shouldReverse: false, duration: 300);
  }

  void _handleHalfWidthReached() {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(NextTaskAction(store.state.taskState.currentTask!));
  }

  void _handleSwipeUp(DragEndDetails details) {
    logger.i('Swipe up velocity: ${details.primaryVelocity}');
    var currentTask =
        StoreProvider.of<AppState>(context).state.taskState.currentTask;
    if (currentTask == null) {
      return;
    }

    scalingController.forward(from: 0.0);
    _openTaskHistory();
  }

  void _openTaskHistory() {
    var currentTask =
        StoreProvider.of<AppState>(context).state.taskState.currentTask;
    if (currentTask == null) {
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          // Apply curve to the animation
          var curvedAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ));

          return FadeTransition(
            opacity: curvedAnimation,
            child: TaskHistoryPage(
              task: currentTask,
              animation: curvedAnimation,
              onDismissed: _onTaskHistoryPageDismissedHandler,
            ),
          );
        },
      ),
    );
  }

  void _onTaskHistoryPageDismissedHandler(BuildContext context) {
    logger.i('Task history page dismissed');
    scalingController.reverse();
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
            body: GestureDetector(
              onVerticalDragEnd: _handleSwipeUp,
              child: buildScalable(Stack(children: [
                Container(color: Colors.black),
                Stack(
                  children: [
                    _buildBackgroundContent(
                        currentTask, nextTask, currentTaskColor, context),
                    _buildHeaderAndFooter(
                        currentTask, currentTaskColor, context),

                    // Footer at bottom of the screen
                  ],
                )
              ])),
            ),
          );
        });
  }

  Widget _buildBackgroundContent(Task? currentTask, Task? nextTask,
      TaskColorSet currentTaskColor, BuildContext context) {
    return Stack(
      children: [
        if (nextTask == null && currentTask == null)
          NoTaskAvailable(taskColor: AppTheme.appTaskColor(context)),
        if (nextTask != null)
          NotDraggingTaskContainer(
            task: nextTask,
            taskColor: currentTaskColor.colorFromRating(nextTask.ratingEnum),
          ),
        if (currentTask != null)
          TaskContainer(
            task: currentTask,
            taskColor: currentTaskColor.colorFromRating(currentTask.ratingEnum),
            onHalfWidthReached: () => _handleHalfWidthReached(),
          ),
      ],
    );
  }

  Widget _buildHeaderAndFooter(
      Task? currentTask, TaskColorSet currentTaskColor, BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Header(
          task: currentTask,
          taskColor: currentTask != null
              ? currentTaskColor.colorFromRating(currentTask.ratingEnum)
              : AppTheme.appTaskColor(context),
        ),
        if (currentTask != null)
          Footer(
            task: currentTask,
            taskColor: currentTaskColor.colorFromRating(currentTask.ratingEnum),
          ),
      ],
    ));
  }
}
