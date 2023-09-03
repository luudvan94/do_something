import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/text_editor.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

class AddTaskNameState extends AddTaskBaseState {
  var _name = '';

  @override
  void apply(AddTaskMediator mediator) {
    var widget = TextEditor(
        key: const ValueKey('name'),
        placeholder: 'What do I want to do huuuh?',
        value: _name,
        onChanged: (value) {
          _name = value;
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
