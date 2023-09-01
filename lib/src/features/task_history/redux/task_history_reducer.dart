import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/features/task_history/redux/task_history_state.dart';

TaskHistoryState taskHistoryReducer(TaskHistoryState state, action) {
  if (action is AddTaskHistoryAction) {
    return addTaskHistoryHandler(state, action);
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
