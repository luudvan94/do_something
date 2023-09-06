import 'dart:convert';

import 'package:do_something/src/features/add_task/widgets/selector_button.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';
import 'package:do_something/src/mock/mock_task_history_state.dart';
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
  return state.copyWith(histories: [...state.histories, action.history]);
}

typedef CallbackAction = Box Function(String boxName);
TaskHistoryState loadHistoriesHandler(
  TaskHistoryState state,
  LoadHistoriesAction action,
  CallbackAction getBox,
) {
  logger.i('Loading histories for task: ${action.taskId}');
  return mockTaskHistoryState;
  // if (state.taskId != null && state.taskId == action.taskId) {
  //   logger.i('Histories already loaded for task: ${action.taskId}');
  //   return state;
  // }

  // logger.i('Loading histories for task: ${action.taskId}');
  // var box = getBox(Constants.historyBoxName);
  // var dynamic = box.get(action.taskId, defaultValue: []) as List;
  // var jsonStringList = dynamic.cast<String>();
  // var histories = jsonStringList
  //     .map((jsonString) => TaskHistory.fromJson(jsonDecode(jsonString)))
  //     .toList();
  // logger.i('Loaded histories: $histories');
  // // return new state
  // return state.copyWith(histories: histories, taskId: action.taskId);
}
