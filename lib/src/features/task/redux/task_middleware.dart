import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:redux/redux.dart';

Middleware<AppState> saveTaskMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is TaskAction) {
      action.task.save();
    }
  };
}
