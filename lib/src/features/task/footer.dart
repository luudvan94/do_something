import 'package:do_something/src/features/task/task.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final Task task;

  const Footer({Key? key, required this.task}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // reverse makes it go back and forth

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              );
            },
            child: IconButton(
              onPressed: () {},
              iconSize: 32,
              icon: Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }
}
