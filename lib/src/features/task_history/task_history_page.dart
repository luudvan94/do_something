import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/modal_scaffold.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:do_something/src/features/task_history/task_history_detail_page.dart';
import 'package:do_something/src/features/task_history/widgets/task_history_list.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef CallbackAction = void Function(BuildContext context);

class TaskHistoryPage extends StatefulWidget {
  final Task task;
  final Animation<double> animation;
  final CallbackAction onDismissed;

  const TaskHistoryPage({
    Key? key,
    required this.task,
    required this.animation,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _loadHistories();
    });
  }

  void _loadHistories() {
    StoreProvider.of<AppState>(context)
        .dispatch(LoadHistoriesAction(widget.task.id));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskHistoryState>(
        converter: (store) => store.state.taskHistoryState,
        builder: (context, historyState) {
          logger.i('Task history state: ${historyState.histories}}');

          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(widget.animation),
            child: ModalScaffold(
              onDismissed: _onDismissed,
              spacerColor: Colors.black87.withOpacity(0.5),
              child: TaskHistoryList(
                taskHistories: historyState.histories,
                callbackAction: _onTaskHistoryCellTapped,
              ),
            ),
          );
        });
  }

  void _onDismissed(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    widget.onDismissed(context);
  }

  void _onTaskHistoryCellTapped(BuildContext context, TaskHistory taskHistory) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return TaskHistoryDetailPage(
            onDismissed: _onDismissed,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Customize the transitions here
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
