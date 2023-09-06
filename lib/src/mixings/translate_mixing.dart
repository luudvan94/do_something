import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

const animationDurationInMilliseconds = 300;

mixin TranslateMixing<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController _translateController;
  late Animation<Offset> _translateAnimation;

  @override
  void initState() {
    super.initState();
    _translateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: animationDurationInMilliseconds),
    );

    _translateAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _translateController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void translate({required Offset begin, Offset end = Offset.zero}) {
    _translateController.reset();
    _translateAnimation = Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: _translateController,
        curve: Curves.easeInOut,
      ),
    );

    _translateController.forward(from: 0);
  }

  Widget buildTranslable(Widget child) {
    return SlideTransition(
      position: _translateAnimation,
      child: child,
    );
  }

  @override
  void dispose() {
    _translateController.dispose();
    super.dispose();
  }
}
