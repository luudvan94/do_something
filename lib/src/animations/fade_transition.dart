import 'package:flutter/material.dart';

typedef TransitionCallback = Widget Function(
    BuildContext, Animation<double>, Animation<double>);

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

  static void by(BuildContext context, TransitionCallback callback) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          // Apply curve to the animation
          return FadeInTransition(
            animation: animation,
            child: callback(context, animation, secondaryAnimation),
          );
        },
      ),
    );
  }
}
