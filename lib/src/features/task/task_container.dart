import 'package:do_something/src/features/task/drag_clipper.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:do_something/src/mixings/bouncing_mixing.dart';
import 'package:do_something/src/mixings/dragging_mixing.dart';
import 'package:do_something/src/theme/task_colors.dart';
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
        DraggableMixing<TaskContainer> {
  double get horizontalDragLength => offset.dx;

  @override
  void initState() {
    super.initState();
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

  @override
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
          child: ClipPath(
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
          ),
        ));
  }
}
