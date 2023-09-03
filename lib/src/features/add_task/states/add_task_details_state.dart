import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/text_editor.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

class AddTaskDetailsState extends AddTaskBaseState {
  var _details = '';

  @override
  void apply(AddTaskMediator mediator) {
    logger.i('AddTaskDetailsState.apply');
    _details = mediator.taskBuilder.details;

    mediator.updateStatus(CurrentStateStatus.completed);

    var widget = TextEditor(
        key: const ValueKey('details'),
        value: _details,
        placeholder: 'details, no?',
        onChanged: (value) {
          _details = value;
        },
        onSubmitted: (value) {
          _details = value;
          mediator.taskBuilder.addDetails(_details);
          mediator.transitionToNextState();
        });

    mediator.setChildWidget(widget);
  }

  @override
  void onGoBack(BuildContext context, AddTaskMediator mediator) {
    mediator.transitionToPreviousState();
  }

  @override
  void onGoNext(BuildContext context, AddTaskMediator mediator) {
    mediator.taskBuilder.addDetails(_details);
    mediator.transitionToNextState();
  }
}
