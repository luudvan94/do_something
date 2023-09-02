import 'package:flutter/material.dart';

class UpAndFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const UpAndFadeTransition(
      {Key? key, required this.animation, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      ),
    );

    final translateYOffset = Tween<Offset>(
      begin: const Offset(0, 0.01),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutQuint,
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: translateYOffset,
        child: child,
      ),
    );
  }
}
