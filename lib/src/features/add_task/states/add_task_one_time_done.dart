import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/luu_selector.dart';
import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

class IdentifiableString implements Identifiable {
  final String value;

  IdentifiableString(this.value);

  @override
  String get id => value;
}

class AddTaskOneTimeDoneState extends AddTaskBaseState {
  final List<IdentifiableString> answers = [
    IdentifiableString('yes'),
    IdentifiableString('no'),
  ];
  IdentifiableString? _selected;

  String _getLabel<T extends Identifiable>(T item) {
    return (item as IdentifiableString)!.value;
  }

  void _onSelected<T extends Identifiable>(T item, AddTaskMediator mediator) {
    _selected = item as IdentifiableString;
    mediator.taskBuilder.addIsOneTimeDone(_selected!.value == 'yes');
    mediator.updateStatus(CurrentStateStatus.completed);
  }

  @override
  void apply(AddTaskMediator mediator) {
    _selected = mediator.taskBuilder.isOneTimeDone != null
        ? (mediator.taskBuilder.isOneTimeDone! == true
            ? answers[0]
            : answers[1])
        : null;
    logger.i('AddTaskOneTimeDoneState.apply: selected: ${_selected?.value}');

    mediator.updateStatus(_selected != null
        ? CurrentStateStatus.completed
        : CurrentStateStatus.notCompleted);

    var widget = LuuSelector(
        key: const Key('AddTaskOneTimeDoneState'),
        items: answers,
        getLabel: _getLabel,
        selectedItems: _selected == null ? {} : {_selected!},
        onSelected: <T extends Identifiable>(T rating) {
          _onSelected(rating, mediator);
        });

    mediator.setChildWidget(widget);
  }

  @override
  void onGoBack(BuildContext context, AddTaskMediator mediator) {
    mediator.transitionToPreviousState();
  }

  @override
  void onGoNext(BuildContext context, AddTaskMediator mediator) {
    logger.i('AddTaskOneTimeDoneState.onGoNext');
  }
}
