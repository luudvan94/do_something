import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:redux/redux.dart';

Middleware<AppState> loggingMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.i('Action: $action');
    next(action);
    logger.i('State: ${store.state}');
  };
}
