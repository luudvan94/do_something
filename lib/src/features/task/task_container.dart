import 'package:do_something/src/features/task/drag_clipper.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:do_something/src/mixings/bouncing_mixing.dart';
import 'package:do_something/src/mixings/dragging_mixing.dart';
import 'package:do_something/src/mixings/scaling_mixing.dart';
import 'package:do_something/src/theme/task_colors.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define a "center area" threshold, e.g., 20% of screen dimensions
    double horizontalThreshold = screenWidth * 0.2;
    double verticalThreshold = screenHeight * 0.2;

    // Calculate the center area boundaries
    double horizontalCenterStart = (screenWidth - horizontalThreshold) / 2;
    double horizontalCenterEnd = (screenWidth + horizontalThreshold) / 2;
    double verticalCenterStart = (screenHeight - verticalThreshold) / 2;
    double verticalCenterEnd = (screenHeight + verticalThreshold) / 2;

    // Check if the tap is within the center area
    if (details.localPosition.dx >= horizontalCenterStart &&
        details.localPosition.dx <= horizontalCenterEnd &&
        details.localPosition.dy >= verticalCenterStart &&
        details.localPosition.dy <= verticalCenterEnd) {
      logger.i('Tap is within the center area');
      scalingController.forward(from: 0.0);
    }
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
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(adjustedOpacity),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: buildScalable(ClipPath(
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
          )),
        ));
  }
}
