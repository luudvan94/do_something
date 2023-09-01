import 'package:flutter/material.dart';

mixin BounceableMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticIn),
    );

    _bounceController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bounceController.reverse();
      }
    });

    startBoucingEffect();
  }

  void startBoucingEffect() {
    _bounceController.forward(from: 0);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Widget buildBounceable(Widget child) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) => Transform.scale(
        scale: _bounceAnimation.value,
        child: child,
      ),
      child: child,
    );
  }
}
