import 'package:do_something/src/features/models/task.dart';
import 'package:flutter/material.dart';

class TaskContent extends StatelessWidget {
  final Task task;

  const TaskContent({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        task.name,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
