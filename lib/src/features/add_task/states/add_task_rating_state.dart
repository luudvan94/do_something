import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/luu_selector.dart';
import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

const oneTab = '  ';

class AddTaskRatingState extends AddTaskBaseState {
  List<Identifiable> ratings =
      Rating.values.map((rating) => IdentifiableRating(rating)).toList();
  IdentifiableRating? selectedRating;

  String _getLabel<T extends Identifiable>(T item) {
    return (item as IdentifiableRating).rating.name + oneTab + item.emoji;
  }

  void _onSelected<T extends Identifiable>(T item, AddTaskMediator mediator) {
    logger.i('Selected rating: (${(item as IdentifiableRating).name})');
    selectedRating = item;
    mediator.taskBuilder.addRating(item.rating);
  }

  @override
  void apply(AddTaskMediator mediator) {
    selectedRating = mediator.taskBuilder.rating != null
        ? (ratings.firstWhere((rating) =>
            (rating as IdentifiableRating).name ==
            mediator.taskBuilder.rating!.toName()) as IdentifiableRating)
        : null;

    logger.i(
        'AddTaskRatingState.apply: selectedRating: ${selectedRating?.name}}');

    var widget = LuuSelector(
        key: const Key('AddTaskRatingState'),
        items: ratings,
        getLabel: _getLabel,
        isMultipleSelection: false,
        selectedItems: selectedRating == null ? {} : {selectedRating!},
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
    if (selectedRating == null) {
      //TODO: show error
      return;
    }

    mediator.taskBuilder.addRating(selectedRating!.rating);
    mediator.transitionToNextState();
  }
}
