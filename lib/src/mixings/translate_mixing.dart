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
  }

  void translate({required Offset offset}) {
    _translateController.reset();
    _translateAnimation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
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
