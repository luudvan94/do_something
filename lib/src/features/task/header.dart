import 'package:do_something/src/animations/up_and_fade_transition.dart';
import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Task task;

  const Header({Key? key, required this.task}) : super(key: key);

  void _onAddButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddTaskPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Enter transition when you push the page onto the stack
          Widget enterTransition =
              UpAndFadeTransition(animation: animation, child: child);

          // Exit transition when you pop the page from the stack
          return enterTransition;
        },
        transitionDuration: const Duration(milliseconds: 300),
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
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _onAddButtonPressed(context),
                iconSize: 32,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
