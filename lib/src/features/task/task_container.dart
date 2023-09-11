import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task/drag_clipper.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/mixings/bouncing_mixing.dart';
import 'package:do_something/src/mixings/dragging_mixing.dart';
import 'package:do_something/src/mixings/scaling_mixing.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:do_something/src/utils/date.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef CallbackAction = void Function();

class TaskContainer extends StatefulWidget {
  final Task task;
  final TaskColor taskColor;
  final Function onHalfWidthReached;
  final CallbackAction onAddCommentRequest;

  const TaskContainer({
    Key? key,
    required this.task,
    required this.taskColor,
    required this.onHalfWidthReached,
    required this.onAddCommentRequest,
  }) : super(key: key);

  @override
  State createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer>
    with
        TickerProviderStateMixin,
        BounceableMixin<TaskContainer>,
        DraggableMixing<TaskContainer>,
        ScalingMixin<TaskContainer> {
  double get horizontalDragLength => offset.dx;

  @override
  void initState() {
    super.initState();
    initScaling(1.0, 0.97, shouldReverse: true, duration: 50);
  }

  @override
  void handlePanEnd(DragEndDetails details) {
    if (horizontalDragLength >= MediaQuery.of(context).size.width / 3) {
      startBoucingEffect(); // bouncing TaskContent
    }

    if (horizontalDragLength >= MediaQuery.of(context).size.width / 2) {
      logger.i('half width reached');
      widget.onHalfWidthReached();
    }

    startDraggingEffect();
  }

  void _doubleTapHandler() {
    var store = StoreProvider.of<AppState>(context);

    var currentTask = store.state.taskState.currentTask;
    if (currentTask == null) {
      return;
    }

    if (currentTask.isDoneForTheDay) {
      // add, update comment
      logger.i('add, update comment');
      widget.onAddCommentRequest();
      return;
    }

    scalingController.forward(from: 0.0);
    store.dispatch(MarkTaskDoneAction(currentTask));

    var taskHistory = TaskHistory.complete(currentTask, '');
    store.dispatch(AddTaskHistoryAction(taskHistory));
  }

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;
    double normalizedOffset = (offset.dx / halfScreenWidth).clamp(0.3, 1.0);

    // Apply a scaling factor to slow down the opacity change
    double scaledOffset = normalizedOffset * 0.7;

    // Adjust the opacity
    double adjustedOpacity = 1.0 - scaledOffset;

    return GestureDetector(
        onPanStart: handlePanStart,
        onPanUpdate: handlePanUpdate,
        onPanEnd: handlePanEnd,
        onDoubleTap: _doubleTapHandler,
        child: Stack(
          children: [
            _buildShadowContainer(adjustedOpacity),
            buildScalable(ClipPath(
              clipper: DragClipper(offset: offset),
              child: Container(
                color: widget.taskColor.background,
                child: buildBounceable(
                  !widget.task.isDoneForTheDay
                      ? TaskContent(
                          task: widget.task,
                          taskColor: widget.taskColor,
                        )
                      : _buildDoneConfirmation(
                          context, widget.task, widget.taskColor),
                ),
              ),
            ))
          ],
        ));
  }

  Widget _buildShadowContainer(double opacity) {
    return Container(
      color: Colors.black.withOpacity(opacity),
    );
  }

  Widget _buildDoneConfirmation(
      BuildContext context, Task task, TaskColor taskColor) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        AutoSizeText(
          'done',
          maxFontSize: 100,
          minFontSize: 70,
          style: AppTheme.textStyle(context)
              .bodyMedium!
              .copyWith(color: taskColor.foreground),
        ),
        AutoSizeText(
          task.isOneTimeDone
              ? 'this is one time job, and you completed it'
              : 'your next review date will be ${task.reviewDate.formattedDate()}',
          maxFontSize: 60,
          minFontSize: 40,
          style: AppTheme.textStyle(context)
              .bodyMedium!
              .copyWith(color: taskColor.foreground),
        ),
        const Spacer(),
        const Spacer(),
      ],
    ));
  }
}
