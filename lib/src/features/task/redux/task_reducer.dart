// create taskStateReduce
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';

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

  return state;
}

TaskState newTaskHandler(TaskState state, NewTaskAction action) {
  // add new task to state
  // return new state
  return state.copyWith(tasks: [...state.tasks, action.task]);
}

// create delete handler
TaskState deleteTaskHandler(TaskState state, DeleteTaskAction action) {
  // delete task from state
  // return new state
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
