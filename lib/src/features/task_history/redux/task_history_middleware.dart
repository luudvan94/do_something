import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/features/task_history/redux/task_history.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';

Middleware<AppState> saveTaskHistoryMiddleware(TaskHistorySaver saver) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is AddTaskHistoryAction) {
      logger.i('Saving task history to Hive');
      saver.saveHistories(store);
    }
  };
}

class TaskHistorySaver {
  static const sharedInstance = TaskHistorySaver._();

  const TaskHistorySaver._();
  void saveHistories(Store<AppState> store) {
    var box = Hive.box(appBoxName);
    box.put(taskHistoryKey, store.state.taskHistoryState.histories);
  }
}
