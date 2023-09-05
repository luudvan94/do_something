import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/utils/constants.dart';
import 'package:do_something/src/utils/hive.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';

Middleware<AppState> saveTaskHistoryMiddleware(TaskHistorySaver saver) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is AddTaskHistoryAction || action is LoadHistoriesAction) {
      logger.i('Saving task history to Hive');
      var taskId = action is TaskHistoryAction
          ? action.history.taskId
          : (action as LoadHistoriesAction).taskId;
      saver.saveHistories(store, taskId);
    }
  };
}

typedef CallbackAction = Box Function(String boxName);

class TaskHistorySaver {
  late CallbackAction _getBox;
  static var sharedInstance = TaskHistorySaver._(getBox);

  TaskHistorySaver._(CallbackAction getBox) {
    _getBox = getBox;
  }

  void saveHistories(Store<AppState> store, String taskId) {
    var box = _getBox(Constants.historyBoxName);
    box.put(taskId,
        store.state.taskHistoryState.histories.map((item) => item.toJson()));
  }
}
