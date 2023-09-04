import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/text_editor.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

class AddTaskNameState implements AddTaskBaseState {
  var _name = '';

  void _onValueChanged(String value, AddTaskMediator mediator) {
    _name = value;

    if (validate(value)) {
      mediator.updateStatus(CurrentStateStatus.completed);
    } else {
      mediator.updateStatus(CurrentStateStatus.notCompleted);
    }
  }

  @override
  void apply(AddTaskMediator mediator) {
    _name = mediator.taskBuilder.name != null ? mediator.taskBuilder.name! : '';

    mediator.updateStatus(validate(_name)
        ? CurrentStateStatus.completed
        : CurrentStateStatus.notCompleted);

    var widget = TextEditor(
        key: const ValueKey('name'),
        placeholder: 'What do I want to do huuuh?',
        value: _name,
        onChanged: (value) {
          _onValueChanged(value, mediator);
        },
        onSubmitted: (value) {
          _name = value;
          if (!validate(_name)) {
            // TODO: show error
            return;
          }

          mediator.taskBuilder.addName(value);
          mediator.transitionToNextState();
        });

    mediator.setChildWidget(widget);
  }

  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }

  @override
  void onGoBack(BuildContext context, AddTaskMediator mediator) {
    logger.i('AddTaskNameState.onGoBack');
    Navigator.pop(context);
  }

  @override
  void onGoNext(BuildContext context, AddTaskMediator mediator) {
    logger.i('AddTaskNameState.onGoNext');
    if (!validate(_name)) {
      //TODO: show error
      return;
    }

    mediator.taskBuilder.addName(_name);
    mediator.transitionToNextState();
  }
}
