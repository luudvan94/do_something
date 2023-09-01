import 'package:do_something/src/features/task/drag_clipper.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/features/task/task_content.dart';
import 'package:flutter/material.dart';
import 'package:do_something/src/features/task/rating.dart';

class TaskContainer extends StatefulWidget {
  final Task task;
  final Function onHalfWidthReached;

  TaskContainer({required this.task, required this.onHalfWidthReached});

  @override
  _TaskContainerState createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer>
    with TickerProviderStateMixin {
  Offset offset = Offset.zero;

  late AnimationController _draggingController;
  late Animation<Offset> _animation;

  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initBounceEffect();
  }

  void _initControllers() {
    _draggingController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() => setState(() => offset = _animation.value));
  }

  void _initBounceEffect() {
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticIn),
    );

    _bounceController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bounceController.reverse();
      }
    });
    _bounceController.forward(from: 0);
  }

  @override
  void dispose() {
    _draggingController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _handlePanStart(DragStartDetails details) =>
      offset = Offset(0, details.localPosition.dy);

  void _handlePanUpdate(DragUpdateDetails details) {
    _draggingController.stop();
    double halfWidth = MediaQuery.of(context).size.width / 2;
    double newDx = (offset.dx + details.delta.dx).clamp(0, halfWidth);
    setState(() => offset = Offset(newDx, offset.dy + details.delta.dy));
  }

  void _handlePanEnd(DragEndDetails details) async {
    if (offset.dx >= MediaQuery.of(context).size.width / 2) {
      widget.onHalfWidthReached();
    }

    _bounceController.forward(from: 0);

    _animation = Tween<Offset>(begin: offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _draggingController, curve: Curves.elasticOut),
    );
    _draggingController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: ClipPath(
        clipper: DragClipper(offset: offset),
        child: Container(
          color: widget.task.rating.getColorFromTheme(context),
          child: AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) => Transform.scale(
              scale: _bounceAnimation.value,
              child: child,
            ),
            child: TaskContent(task: widget.task),
          ),
        ),
      ),
    );
  }
}
