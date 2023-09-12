import 'package:do_something/src/features/add_task/add_task_page.dart';
import 'package:do_something/src/features/add_task/states/add_task_complete_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/luu_selector.dart';
import 'package:do_something/src/features/models/rating.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

const oneTab = '  ';

class AddTaskRatingState extends AddTaskCompleteState {
  List<Identifiable> ratings =
      Rating.values.map((rating) => IdentifiableRating(rating)).toList();
  IdentifiableRating? selectedRating;

  String _getLabel<T extends Identifiable>(T item) {
    return (item as IdentifiableRating).rating.toName() + oneTab + item.emoji;
  }

  void _onSelected<T extends Identifiable>(T item, AddTaskMediator mediator) {
    logger.i('Selected rating: (${(item as IdentifiableRating).name})');
    selectedRating = item;
    mediator.taskBuilder.addRating(item.rating);
    mediator.updateStatus(CurrentStateStatus.completed);
  }

  @override
  void apply(AddTaskMediator mediator) {
    //TODO: redo a logic to be more understandable
    selectedRating = mediator.taskBuilder.rating != null
        ? (ratings.firstWhere((rating) =>
            (rating as IdentifiableRating).name ==
            mediator.taskBuilder.rating!.toName()) as IdentifiableRating)
        : null;

    logger.i(
        'AddTaskRatingState.apply: selectedRating: ${selectedRating?.name}}');

    mediator.updateStatus(selectedRating != null
        ? CurrentStateStatus.completed
        : CurrentStateStatus.notCompleted);

    var widget = LuuSelector(
        key: const Key('AddTaskRatingState'),
        label: 'how often would you like this to occur?',
        items: ratings,
        getLabelForItem: _getLabel,
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
    super.onGoNext(context, mediator);
  }
}
