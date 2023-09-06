import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef CallbackAction = void Function();

class Header extends StatefulWidget {
  final CallbackAction onBack;
  final CallbackAction onContinue;
  final IconData backIcon;
  final IconData continueIcon;
  final CurrentStateStatus status;

  const Header({
    Key? key,
    required this.onBack,
    required this.onContinue,
    this.backIcon = Icons.arrow_back_ios,
    this.continueIcon = Icons.arrow_forward_ios,
    this.status = CurrentStateStatus.notCompleted,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isCompleted() {
    return widget.status == CurrentStateStatus.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button
        IconButton(
            onPressed: () {
              widget.onBack();
            },
            icon: Icon(widget.backIcon),
            color: AppTheme.appColors(context).primary),
        // Continue button
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _isCompleted() ? 1.0 + (_controller.value * 0.1) : 1.0,
              child: child,
            );
          },
          child: IconButton(
            onPressed: () {
              widget.onContinue();
            },
            icon: Icon(widget.continueIcon),
            color: _isCompleted()
                ? AppTheme.appColors(context).primary
                : AppTheme.appColors(context).secondary,
          ),
        ),
      ],
    );
  }
}
