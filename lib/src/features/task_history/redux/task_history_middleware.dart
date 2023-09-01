import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:redux/redux.dart';

Middleware<AppState> saveTaskHistoryMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is TaskHistoryAction) {
      action.history.save();
    }
  };
}
