import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';

Middleware<AppState> saveTaskMiddleware(TaskSaver saver) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is NewTaskAction) {
      logger.i('Saving new task to Hive');
      saver.saveTasks(store);
    } else if (action is DeleteTaskAction) {
      logger.i('Deleting task from Hive');
      saver.saveTasks(store);
    } else if (action is TaskAction) {
      logger.i('Updating task to Hive');
      action.task.save();
    }
  };
}

class TaskSaver {
  static const sharedInstance = TaskSaver._();

  const TaskSaver._();

  void saveTasks(Store<AppState> store) {
    var box = Hive.box(appBoxName);
    box.put(tasksKey, store.state.taskState.tasks);
  }
}
