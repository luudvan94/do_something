import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/widgets/task_history_cell.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef TaskHistoryListCallback = void Function(BuildContext, TaskHistory);

class TaskHistoryList extends StatefulWidget {
  final List<TaskHistory> taskHistories;
  final TaskHistoryListCallback callbackAction;

  const TaskHistoryList({
    Key? key,
    required this.taskHistories,
    required this.callbackAction,
  }) : super(key: key);

  @override
  State<TaskHistoryList> createState() => _TaskHistoryListState();
}

class _TaskHistoryListState extends State<TaskHistoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appColors(context).background.withOpacity(1),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.taskHistories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("logs", style: AppTheme.textStyle(context).headline3),
            );
          } else {
            var realIndex = index - 1;
            var logDate = widget.taskHistories[realIndex].doneDate;
            var comment = widget.taskHistories[realIndex].details
                    is HistoryTypeCompleteDetails
                ? (widget.taskHistories[realIndex].details
                        as HistoryTypeCompleteDetails)
                    .comment
                : null;
            var eventType = widget.taskHistories[realIndex].type;
            return TaskHistoryCell(
              logDate: logDate,
              comment: comment,
              eventType: eventType,
              callbackAction: () {
                widget.callbackAction(context, widget.taskHistories[index - 1]);
              },
            );
          }
        },
      ),
    );
  }
}
