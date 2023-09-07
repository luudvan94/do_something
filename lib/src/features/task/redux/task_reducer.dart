// create taskStateReduce
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/utils/logger.dart';

TaskState taskStateReduce(TaskState state, dynamic action) {
  // add switch case for action
  if (action is NewTaskAction) {
    return newTaskHandler(state, action);
  }

  // add case for delete action
  if (action is DeleteTaskAction) {
    return deleteTaskHandler(state, action);
  }

  // add case for update action
  if (action is UpdateTaskAction) {
    return updateTaskHandler(state, action);
  }

  if (action is NextTaskAction) {
    return nextTaskHandler(state, action);
  }

  if (action is MarkTaskDoneAction) {
    return markTaskAsDone(state, action);
  }

  return state;
}

TaskState newTaskHandler(TaskState state, NewTaskAction action) {
  logger.i('New task: ${action.task}');
  // add new task to state
  // return new state
  return state.copyWith(tasks: [...state.tasks, action.task]);
}

// create delete handler
TaskState deleteTaskHandler(TaskState state, DeleteTaskAction action) {
  // delete task from state
  // return new state
  var updatedTasks =
      state.tasks.where((task) => task.id != action.task.id).toList();
  logger.i('Updated tasks: $updatedTasks');
  return state.copyWith(
    tasks: state.tasks.where((task) => task.id != action.task.id).toList(),
  );
}

// create update handler
TaskState updateTaskHandler(TaskState state, UpdateTaskAction action) {
  // update task in state
  // return new state
  return state.copyWith(
    tasks: state.tasks.map((task) {
      if (task.id == action.task.id) {
        return action.task;
      }
      return task;
    }).toList(),
  );
}

TaskState markTaskAsDone(TaskState state, MarkTaskDoneAction action) {
  logger.i('Mark task as done');
  state.taskManager.markDone();
  return state.copyWith(taskManager: state.taskManager);
}

TaskState nextTaskHandler(TaskState state, NextTaskAction action) {
  logger.i('Next task');
  state.taskManager.calcuateNextTask();

  return state.copyWith(taskManager: state.taskManager);
}
