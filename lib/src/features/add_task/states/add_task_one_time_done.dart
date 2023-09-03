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
  late IdentifiableString _selected;

  String _getLabel<T extends Identifiable>(T item) {
    return (item as IdentifiableString)!.value;
  }

  void _onSelected<T extends Identifiable>(T item, AddTaskMediator mediator) {
    _selected = item as IdentifiableString;
    mediator.taskBuilder.addIsOneTimeDone(_selected.value == 'yes');
  }

  @override
  void apply(AddTaskMediator mediator) {
    _selected = mediator.taskBuilder.isOneTimeDone ? answers[0] : answers[1];

    logger.i('AddTaskOneTimeDoneState.apply: selected: ${_selected.value}');

    var widget = LuuSelector(
        key: const Key('AddTaskOneTimeDoneState'),
        items: answers,
        getLabel: _getLabel,
        selectedItems: {_selected},
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
