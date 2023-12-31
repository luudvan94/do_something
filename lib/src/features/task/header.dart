import 'package:do_something/src/animations/fade_transition.dart';
import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/settings/setting_page.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Task? task;
  final TaskColor taskColor;

  const Header({
    Key? key,
    required this.task,
    required this.taskColor,
  }) : super(key: key);

  void _onAddButtonPressed(BuildContext context) {
    FadeInTransition.by(context,
        (context, animation, secondaryAnimation) => const AddTaskPage());
  }

  void _onEditButtonPressed(BuildContext context) {
    FadeInTransition.by(
        context,
        (context, animation, secondaryAnimation) => AddTaskPage(
              task: task,
            ));
  }

  void _onSettingButtonPressed(BuildContext context) {
    FadeInTransition.by(
        context,
        (context, animation, secondaryAnimation) => SettingPage(
              animation: animation,
              onDismissed: (_) {},
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _onSettingButtonPressed(context);
            },
            icon: const Icon(Icons.settings),
            color: taskColor.foreground,
          ),
          Row(
            children: [
              task != null
                  ? IconButton(
                      onPressed: () => {_onEditButtonPressed(context)},
                      icon: const Icon(Icons.edit),
                      color: taskColor.foreground)
                  : const SizedBox.shrink(),
              IconButton(
                onPressed: () => {_onAddButtonPressed(context)},
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
