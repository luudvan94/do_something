import 'package:flutter/material.dart';

mixin FadingMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController _fadingController;
  late Animation<double> _fadingAnimation;

  @override
  void initState() {
    super.initState();
    _fadingController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadingController.stop();
      }
    });

    _fadingAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadingController);
  }

  void fadeIn() {
    _fadingController.reset();
    _fadingController.forward();
  }

  void fadeOut() {
    _fadingController.reset();
    _fadingController.reverse();
  }

  Widget buildFadable(Widget child) {
    return FadeTransition(
      opacity: _fadingAnimation,
      child: child,
    );
  }

  @override
  void dispose() {
    _fadingController.dispose();
    super.dispose();
  }
}
