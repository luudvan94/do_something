import 'package:do_something/src/animations/fade_transition.dart';
import 'package:do_something/src/features/add_comment/add_task_comment_page.dart';
import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/footer.dart';
import 'package:do_something/src/features/task/header.dart';
import 'package:do_something/src/features/task/no_task_available.dart';
import 'package:do_something/src/features/task/not_dragging_task_container.dart';
import 'package:do_something/src/features/task/notification_carousel.dart';
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
  Task? get currentTask =>
      StoreProvider.of<AppState>(context).state.taskState.currentTask;
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
    if (currentTask == null) {
      return;
    }

    FadeInTransition.by(
        context,
        (context, animation, secondaryAnimation) => TaskHistoryPage(
            task: currentTask!,
            animation: animation,
            onDismissed: _onModalDismissed));
  }

  void _openCommentEdit() {
    if (currentTask == null) {
      return;
    }

    var store = StoreProvider.of<AppState>(context);
    var history = store.state.taskHistoryState.latestHistory;
    if (history == null || history.details is! HistoryTypeCompleteDetails) {
      return;
    }

    scalingController.forward(from: 0.0);
    logger.i('Open comment edit');
    FadeInTransition.by(
        context,
        (context, animation, secondaryAnimation) => AddTaskCommentPage(
            history: history,
            animation: animation,
            onDismissed: _onModalDismissed));
  }

  void _onModalDismissed(BuildContext context) {
    scalingController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskState>(
        converter: (store) => store.state.taskState,
        builder: (context, taskState) {
          var currentTask = taskState.currentTask;
          var nextTask = taskState.nextTask;
          var selectedColorSetId = taskState.selectedColorSetId;
          var currentTaskColor = TaskColorSet.allSets.where((element) {
            return element.id == selectedColorSetId;
          }).first;

          return Scaffold(
            backgroundColor: AppTheme.appColors(context).background,
            body: GestureDetector(
              onVerticalDragEnd: _handleSwipeUp,
              child: buildScalable(Stack(children: [
                Container(color: Colors.black),
                Stack(
                  children: [
                    _buildContent(
                        currentTask, nextTask, currentTaskColor, context),
                    _buildHeaderAndFooter(currentTask, currentTaskColor,
                        taskState.doneTimes, context),

                    // Footer at bottom of the screen
                  ],
                )
              ])),
            ),
          );
        });
  }

  Widget _buildContent(Task? currentTask, Task? nextTask,
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
            onAddCommentRequest: _openCommentEdit,
          ),
      ],
    );
  }

  Widget _buildHeaderAndFooter(Task? currentTask, TaskColorSet currentTaskColor,
      int numberOfDoneTimes, BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Header(
              task: currentTask,
              taskColor: currentTask != null
                  ? currentTaskColor.colorFromRating(currentTask.ratingEnum)
                  : AppTheme.appTaskColor(context),
            ),
            _buildNotification(
                currentTask, numberOfDoneTimes, currentTaskColor, context)
          ],
        ),
        if (currentTask != null)
          Footer(
            task: currentTask,
            taskColor: currentTaskColor.colorFromRating(currentTask.ratingEnum),
          ),
      ],
    ));
  }

  Widget _buildNotification(Task? currentTask, int numberOfDoneTimes,
      TaskColorSet currentTaskColor, BuildContext context) {
    if (currentTask == null) return const SizedBox.shrink();
    return NotificationCarousel(
      currentTask: currentTask,
      numberOfDoneTimes: numberOfDoneTimes,
      currentTaskColor:
          currentTaskColor.colorFromRating(currentTask.ratingEnum),
    );
  }
}
