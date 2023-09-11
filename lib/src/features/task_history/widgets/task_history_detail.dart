import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef OnDismissed = void Function(BuildContext context);
double dragLimit = 100.0;

class TaskHistoryDetail extends StatefulWidget {
  final TaskHistory? history;
  final OnDismissed onGoBack;

  const TaskHistoryDetail({
    Key? key,
    required this.history,
    required this.onGoBack,
  }) : super(key: key);

  @override
  State<TaskHistoryDetail> createState() => _TaskHistoryDetailState();
}

class _TaskHistoryDetailState extends State<TaskHistoryDetail> {
  HistoryType? get historyType => widget.history?.type;

  Task? get task {
    if (historyType == HistoryType.create) {
      return (widget.history?.details as HistoryTypeCreateDetails?)?.task;
    } else if (historyType == HistoryType.delete) {
      return (widget.history?.details as HistoryTypeDeleteDetails?)?.task;
    }
    return null;
  }

  String? get comment => historyType == HistoryType.complete
      ? (widget.history?.details as HistoryTypeCompleteDetails?)?.comment != ''
          ? (widget.history?.details as HistoryTypeCompleteDetails?)?.comment!
          : widget.history?.details is HistoryTypeCompleteDetails
              ? '(no comment)'
              : null
      : null;

  List<TaskDifference> get differences => historyType == HistoryType.update
      ? (widget.history?.details as HistoryTypeUpdateDetails?)?.differences ??
          []
      : [];

  @override
  Widget build(BuildContext context) {
    double dragExtent = 0;
    return WillPopScope(
        onWillPop: () async {
          widget.onGoBack(context);
          return false;
        },
        child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              dragExtent += details.primaryDelta!;
            },
            onHorizontalDragEnd: (details) {
              if (dragExtent.abs() > dragLimit) {
                widget.onGoBack(context);
              }
              dragExtent = 0;
            },
            child: Container(
              color: AppTheme.appColors(context).background.withOpacity(1),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back icon at the top
                    _buildBackButton(context),

                    task != null
                        ? _buildTask(context, task!)
                        : const SizedBox.shrink(),
                    comment != null
                        ? _buildComment(context, comment!)
                        : const SizedBox.shrink(),
                    differences.isNotEmpty
                        ? _buildDifferences(context, differences!)
                        : const SizedBox.shrink(),
                    // Your other widgets come here
                  ],
                ),
              )),
            )));
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          widget.onGoBack(context); // Execute the callback function
        },
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    // assume the task is created
    var textColor = Colors.black;
    var highlightColor = Colors.green[100]!;

    if (historyType == HistoryType.delete) {
      highlightColor = Colors.red[100]!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(context, task.name,
            color: textColor, highlightColor: highlightColor),
        const SizedBox(height: 10),
        _buildText(context, task.details == '' ? '(no details)' : task.details,
            color: textColor, highlightColor: highlightColor),
        const SizedBox(height: 10),
        _buildText(context, task.rating,
            color: textColor, highlightColor: highlightColor),
        const SizedBox(height: 10),
        _buildText(context, task.isOneTimeDone ? 'One time' : 'Recurring',
            color: textColor, highlightColor: highlightColor),
      ],
    );
  }

  Widget _buildComment(BuildContext context, String comment) {
    return _buildText(context, comment,
        color: Colors.black, highlightColor: Colors.blue[100]);
  }

  Widget _buildDifferences(
      BuildContext context, List<TaskDifference> differences) {
    var color = Colors.black;
    var oldHighlight = Colors.red[100]!;
    var newHighlight = Colors.green[100]!;

    List<Widget> differencesText = [];
    for (var diff in differences) {
      var oldValue = _buildText(context, diff.oldValue,
          color: color, highlightColor: oldHighlight);
      var newValue = _buildText(context, diff.newValue,
          color: color, highlightColor: newHighlight);
      differencesText.add(oldValue);
      differencesText.add(const SizedBox(height: 10));
      differencesText.add(newValue);
      differencesText.add(const SizedBox(height: 20));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: differencesText,
    );
  }

  Widget _buildText(BuildContext context, String text,
      {Color color = Colors.black, highlightColor = Colors.transparent}) {
    return Text(
      text,
      style: AppTheme.textStyle(context)
          .bodySmall!
          .copyWith(color: color, backgroundColor: highlightColor),
    );
  }
}
