import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/modal_scaffold.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:do_something/src/features/task_history/widgets/task_history_detail.dart';
import 'package:do_something/src/features/task_history/widgets/task_history_list.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/app_theme.dart';
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

class _TaskHistoryPageState extends State<TaskHistoryPage>
    with TickerProviderStateMixin {
  late AnimationController _historyListController;
  late Animation<Offset> _historyListAnimation;
  late AnimationController _historyDetailController;
  late Animation<Offset> _historyDetailAnimation;
  bool isHistoryDetailPresenting = false;
  TaskHistory? selectedTaskHistory;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _loadHistories();
    });

    _initHistoryListAnimation();
    _initHistoryDetailAnimation();
  }

  void _initHistoryListAnimation() {
    _historyListController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _historyListAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(
      CurvedAnimation(
        parent: _historyListController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _initHistoryDetailAnimation() {
    _historyDetailController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _historyDetailAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _historyDetailController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _loadHistories() {
    var store = StoreProvider.of<AppState>(context);
    var currentTask = store.state.taskState.currentTask;

    if (currentTask != null) {
      logger.i('Loading histories for task: $currentTask');
      store.dispatch(LoadHistoriesAction(currentTask.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskHistoryState>(
        converter: (store) => store.state.taskHistoryState,
        builder: (context, historyState) {
          logger.i('Task history state: ${historyState.histories}}');

          return ModalScaffold(
            animation: widget.animation,
            onDismissed: _onDismissed,
            child: Stack(children: [
              SlideTransition(
                  position: _historyListAnimation,
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child:
                          _buildHistoryList(context, historyState.histories))),
              SlideTransition(
                  position: _historyDetailAnimation,
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildHistoryDetail(context, selectedTaskHistory)))
            ]),
          );
        });
  }

  Widget _buildHistoryList(BuildContext context, List<TaskHistory> histories) {
    return TaskHistoryList(
        taskHistories: histories, callbackAction: _onTaskHistoryCellTapped);
  }

  Widget _buildHistoryDetail(BuildContext context, TaskHistory? history) {
    if (history == null) {
      return Container(
        color: AppTheme.appColors(context).background,
      );
    }

    return TaskHistoryDetail(
      history: history,
      onGoBack: _onHistoryDetailsGoBack,
    );
  }

  void _onDismissed(BuildContext context) {
    logger.i('Task history page dismissed');
    Navigator.pop(context);
    widget.onDismissed(context);
  }

  void _onTaskHistoryCellTapped(BuildContext context, TaskHistory taskHistory) {
    _historyListController.forward(from: 0.0);
    _historyDetailController.forward(from: 0.0);

    setState(() {
      isHistoryDetailPresenting = true;
      selectedTaskHistory = taskHistory;
    });
  }

  void _onHistoryDetailsGoBack(BuildContext context) {
    _historyListController.reverse();
    _historyDetailController.reverse();

    setState(() {
      isHistoryDetailPresenting = false;
    });
  }
}
