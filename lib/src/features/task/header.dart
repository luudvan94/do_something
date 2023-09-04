import 'package:do_something/src/animations/fade_transition.dart';
import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Task? task;
  final TaskColor taskColor;

  const Header({Key? key, this.task, required this.taskColor})
      : super(key: key);

  void _onAddButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddTaskPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Enter transition when you push the page onto the stack
          Widget enterTransition =
              FadeInTransition(animation: animation, child: child);

          // Exit transition when you pop the page from the stack
          return enterTransition;
        },
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: taskColor.foreground,
          ),
          Row(
            children: [
              task != null
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      color: taskColor.foreground)
                  : const SizedBox.shrink(),
              IconButton(
                onPressed: () => _onAddButtonPressed(context),
                iconSize: 32,
                icon: const Icon(Icons.add),
                color: taskColor.foreground,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
