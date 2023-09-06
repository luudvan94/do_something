import 'package:do_something/src/features/task_history/modal_scaffold.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef OnDismissed = void Function(BuildContext context);

class TaskHistoryDetailPage extends StatefulWidget {
  final OnDismissed onDismissed;

  const TaskHistoryDetailPage({
    Key? key,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<TaskHistoryDetailPage> createState() => _TaskHistoryDetailPageState();
}

class _TaskHistoryDetailPageState extends State<TaskHistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ModalScaffold(
      onDismissed: _onDismissed,
      spacerColor: Colors.transparent,
      child: Container(color: AppTheme.appColors(context).background),
    );
  }

  void _onDismissed(BuildContext context) {
    widget.onDismissed(context);
  }
}
