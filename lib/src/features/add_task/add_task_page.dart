import 'package:do_something/src/features/add_task/builder/task_builder.dart';
import 'package:do_something/src/features/add_task/states/add_task_complete_state.dart';
import 'package:do_something/src/features/add_task/states/add_task_details_state.dart';
import 'package:do_something/src/features/add_task/states/add_task_name_state.dart';
import 'package:do_something/src/features/add_task/states/add_task_one_time_done.dart';
import 'package:do_something/src/features/add_task/states/add_task_rating_state.dart';
import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/header.dart';
import 'package:do_something/src/features/add_task/widgets/progress_bar.dart';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/mixings/fading_mixing.dart';
import 'package:do_something/src/mixings/translate_mixing.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

enum CurrentStateStatus { completed, notCompleted }

class AddTaskPage extends StatefulWidget {
  final Task? task;

  const AddTaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage>
    with
        TickerProviderStateMixin,
        FadingMixin<AddTaskPage>,
        TranslateMixing<AddTaskPage>
    implements AddTaskMediator {
  Widget? childWidget;

  AddTaskBaseState get currentState => states[currentStateIndex];

  @override
  late TaskBuilder taskBuilder;
  late List<AddTaskBaseState> states;
  late int currentStateIndex;
  late int currentStep;

  final forwardTranslateAnimationOffset = const Offset(0.1, 0);
  final backwardTranslateAnimationOffset = const Offset(-0.1, 0);

  CurrentStateStatus currentStateStatus = CurrentStateStatus.notCompleted;

  void _onBackButtonPressed(BuildContext context) {
    logger.i('AddTaskPage._onBackButtonPressed');
    currentState.onGoBack(context, this);
  }

  void _onContiueButtonPressed(BuildContext context) {
    logger.i('AddTaskPage._onContiueButtonPressed');
    currentState.onGoNext(context, this);
  }

  @override
  void initState() {
    super.initState();
    taskBuilder = TaskBuilder(task: widget.task);

    _initState();
    transitionToNextState();
  }

  void _initState() {
    states = [
      AddTaskNameState(),
      AddTaskDetailsState(),
      AddTaskOneTimeDoneState(),
      AddTaskRatingState(),
    ];
    currentStateIndex = -1;
    currentStep = 0;
  }

  @override
  void transitionToNextState() {
    translate(begin: backwardTranslateAnimationOffset);
    fadeOut();
    if (currentStateIndex < states.length) {
      setState(() {
        currentStep++;
        currentStateIndex++;
        currentState.apply(this);
      });

      fadeIn();
      translate(begin: forwardTranslateAnimationOffset);
    }
  }

  @override
  void transitionToPreviousState() {
    translate(begin: forwardTranslateAnimationOffset);
    fadeOut();
    if (currentStateIndex > 0) {
      setState(() {
        currentStep--;
        currentStateIndex--;
        currentState.apply(this);
      });

      fadeIn();
      translate(begin: backwardTranslateAnimationOffset);
    }
  }

  @override
  void setChildWidget(Widget childWidget) {
    setState(() {
      this.childWidget = childWidget;
    });
  }

  @override
  void updateStatus(CurrentStateStatus status) {
    setState(() {
      currentStateStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: AppTheme.appColors(context).background,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                onBack: () {
                  _onBackButtonPressed(context);
                },
                onContinue: () {
                  _onContiueButtonPressed(context);
                },
                status: currentStateStatus,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: ProgressBar(
                    numberOfSteps: states.length, currentStep: currentStep),
              ),
              if (childWidget != null)
                Flexible(
                  fit: FlexFit.loose,
                  child: buildTranslable(buildFadable(childWidget!)),
                )
              else
                const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
