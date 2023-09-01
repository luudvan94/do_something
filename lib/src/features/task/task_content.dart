import 'package:do_something/src/features/task/task.dart';
import 'package:flutter/cupertino.dart';
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
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline2?.fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
