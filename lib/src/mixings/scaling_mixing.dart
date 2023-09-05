import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

const animationDurationInMilliseconds = 100;

mixin ScalingMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController scalingController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
  }

  void initScaling(double begin, double end,
      {bool shouldReverse = false, int duration = 500}) {
    scalingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );

    _scaleAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: scalingController,
        curve: Curves.easeInOut,
      ),
    );

    scalingController.addStatusListener((status) {
      if (status == AnimationStatus.completed && shouldReverse) {
        scalingController.reverse();
      }
    });
  }

  Widget buildScalable(Widget child) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: child,
    );
  }

  void disposeScaling() {
    scalingController.dispose();
    super.dispose();
  }
}
