import 'dart:convert';

import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:do_something/src/utils/constants.dart';
import 'package:do_something/src/utils/hive.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:hive/hive.dart';

TaskHistoryState taskHistoryReducer(TaskHistoryState state, action) {
  if (action is AddTaskHistoryAction) {
    return addTaskHistoryHandler(state, action);
  }

  if (action is LoadHistoriesAction) {
    return loadHistoriesHandler(state, action, getBox);
  }

  return state;
}

// add taskhistory handler
TaskHistoryState addTaskHistoryHandler(
    TaskHistoryState state, AddTaskHistoryAction action) {
  // add new task history to state
  // return new state
  logger.i('Adding task history: ${action.history}');
  if (state.taskId != action.history.taskId) {
    return TaskHistoryState(
        histories: [action.history], taskId: action.history.taskId);
  }

  return state.copyWith(histories: [...state.histories, action.history]);
}

//update task history
TaskHistoryState updateTaskHistoryHandler(
    TaskHistoryState state, UpdateTaskHistoryAction action) {
  // update task history
  // return new state
  logger.i('Updating task history: ${action.history}');
  var histories = state.histories.map((history) {
    if (history.id == action.history.id) {
      return action.history;
    }

    return history;
  }).toList();

  return state.copyWith(histories: histories);
}

typedef CallbackAction = Box Function(String boxName);
TaskHistoryState loadHistoriesHandler(
  TaskHistoryState state,
  LoadHistoriesAction action,
  CallbackAction getBox,
) {
  // return mockTaskHistoryState;
  if (state.taskId != null && state.taskId == action.taskId) {
    logger.i('Histories already loaded for task: ${action.taskId}');
    return state;
  }

  logger.i('Loading histories for task: ${action.taskId}');
  var box = getBox(Constants.historyBoxName);
  var dynamic = box.get(action.taskId, defaultValue: []) as List;
  logger.i('Dynamic History count: ${dynamic.length}');
  var jsonStringList = dynamic.cast<String>();
  var histories = jsonStringList
      .map((jsonString) => TaskHistory.fromJson(jsonDecode(jsonString)))
      .toList();
  // return new state
  return TaskHistoryState(histories: histories, taskId: action.taskId);
}
