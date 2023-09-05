import 'package:do_something/src/features/task/drag_clipper.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:do_something/src/mixings/bouncing_mixing.dart';
import 'package:do_something/src/mixings/dragging_mixing.dart';
import 'package:do_something/src/mixings/scaling_mixing.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:do_something/src/utils/constants.dart';
import 'package:do_something/src/utils/helpers.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatefulWidget {
  final Task task;
  final TaskColor taskColor;
  final Function onHalfWidthReached;

  const TaskContainer(
      {Key? key,
      required this.task,
      required this.onHalfWidthReached,
      required this.taskColor})
      : super(key: key);

  @override
  _TaskContainerState createState() => _TaskContainerState();
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
    initScaling(1.0, 0.97, shouldReverse: true, duration: 150);
  }

  @override
  void handlePanEnd(DragEndDetails details) {
    if (horizontalDragLength >= MediaQuery.of(context).size.width / 3) {
      startBoucingEffect(); // bouncing TaskContent
    }

    if (horizontalDragLength >= MediaQuery.of(context).size.width / 2) {
      widget.onHalfWidthReached();
    }

    startDraggingEffect();
  }

  void _tapDownHandler(TapDownDetails details) {
    final Size screenSize = MediaQuery.of(context).size;
    final Offset tapPosition = details.localPosition;

    final Rect centerArea = calculateCenterArea(
      screenSize,
      Constants.VERTICAL_THRESHOLD_PERCENTAGE,
      Constants.VERTICAL_THRESHOLD_PERCENTAGE,
    );

    if (_isTapWithinCenterArea(tapPosition, centerArea)) {
      logger.i('Tap is within the center area');
      scalingController.forward(from: 0.0);
    }
  }

  bool _isTapWithinCenterArea(Offset tapPosition, Rect centerArea) {
    return centerArea.contains(tapPosition);
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
        onTapDown: _tapDownHandler,
        onPanStart: handlePanStart,
        onPanUpdate: handlePanUpdate,
        onPanEnd: handlePanEnd,
        child: Stack(
          children: [
            _buildShadowContainer(adjustedOpacity),
            buildScalable(ClipPath(
              clipper: DragClipper(offset: offset),
              child: Container(
                color: widget.taskColor.background,
                child: buildBounceable(
                  TaskContent(
                    task: widget.task,
                    taskColor: widget.taskColor,
                  ),
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
}
