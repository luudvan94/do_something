import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/widgets/task_history_cell.dart';
import 'package:flutter/material.dart';

class TaskHistoryList extends StatefulWidget {
  final List<TaskHistory> taskHistories;

  const TaskHistoryList({Key? key, required this.taskHistories})
      : super(key: key);

  @override
  State<TaskHistoryList> createState() => _TaskHistoryListState();
}

class _TaskHistoryListState extends State<TaskHistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.taskHistories.length,
      itemBuilder: (context, index) {
        return TaskHistoryCell(taskHistory: widget.taskHistories[index]);
      },
    );
  }
}
