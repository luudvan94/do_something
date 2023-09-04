import 'package:flutter/material.dart';

mixin DraggableMixing<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  Offset offset = Offset.zero;
  late AnimationController _draggingController;
  late Animation<Offset> _draggingAnimation;

  @override
  void initState() {
    super.initState();
    initDraggingController();
  }

  void initDraggingController() {
    _draggingController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {
          offset = _draggingAnimation.value;
        });
      });
  }

  void handlePanStart(DragStartDetails details) {
    offset = Offset(0, details.localPosition.dy);
  }

  void handlePanUpdate(DragUpdateDetails details) {
    _draggingController.stop();
    double halfWidth = MediaQuery.of(context).size.width / 2;
    double newDx = (offset.dx + details.delta.dx).clamp(0, halfWidth);
    setState(() {
      offset = Offset(newDx, offset.dy + details.delta.dy);
    });
  }

  void handlePanEnd(DragEndDetails details) {
    // This remains empty in the mixin. To be overridden in concrete class.
  }

  void startDraggingEffect() {
    _draggingAnimation = Tween<Offset>(begin: offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _draggingController, curve: Curves.elasticOut),
    );
    _draggingController.forward(from: 0);
  }

  @override
  void dispose() {
    _draggingController.dispose();
    super.dispose();
  }
}
