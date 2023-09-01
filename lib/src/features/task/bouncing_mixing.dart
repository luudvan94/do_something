import 'package:flutter/material.dart';

mixin BounceableMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.elasticIn,
      ),
    );

    _bounceController.addListener(() {
      setState(() {});
    });
  }

  void bounce() {
    _bounceController.forward(from: 0).then((_) {
      _bounceController.reverse();
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Widget buildBounceable(Widget child) {
    return Transform.scale(
      scale: _bounceAnimation.value,
      child: child,
    );
  }
}
