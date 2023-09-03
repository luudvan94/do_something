import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_middleware.dart';
import 'package:do_something/src/features/task/redux/task_reducer.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/features/task/task.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_middleware.dart';
import 'package:do_something/src/features/task_history/redux/task_history_reducer.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redux/redux.dart';

var appBoxName = 'doSomgthingAppBox';

class AppState {
  TaskState taskState;
  TaskHistoryState taskHistoryState;

  AppState({required this.taskState, required this.taskHistoryState});
}

AppState appReducer(AppState state, action) {
  return AppState(
    taskState: taskStateReduce(state.taskState, action),
    taskHistoryState: taskHistoryReducer(state.taskHistoryState, action),
  );
}

final List<Middleware<AppState>> appMiddleware = [
  TypedMiddleware<AppState, TaskAction>(
      saveTaskMiddleware(TaskSaver.sharedInstance)),
  TypedMiddleware<AppState, TaskHistoryAction>(
      saveTaskHistoryMiddleware(TaskHistorySaver.sharedInstance)),
];

Future<Store<AppState>> initializeRedux() async {
  await Hive.initFlutter();
  logger.i('Initializing Hive');
  Hive.registerAdapter(TaskAdapter());

  var box = await Hive.openBox(appBoxName);
  var taskState = loadTaskState(box);
  var taskHistoryState = loadTaskHistoryState(box);

  var loadedState =
      AppState(taskState: taskState, taskHistoryState: taskHistoryState);

  final store = Store<AppState>(
    appReducer,
    initialState: loadedState,
    middleware: appMiddleware,
  );

  logger.i('Loaded state: $loadedState');
  return store;
}
