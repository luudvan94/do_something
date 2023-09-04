import 'package:flutter/material.dart';

class FadeInTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const FadeInTransition(
      {Key? key, required this.animation, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
}
