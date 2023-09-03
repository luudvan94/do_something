import 'package:do_something/src/features/add_task/builder/task_builder.dart';
import 'package:do_something/src/features/add_task/states/add_task_details_state.dart';
import 'package:do_something/src/features/add_task/states/add_task_name_state.dart';
import 'package:do_something/src/features/add_task/states/add_task_one_time_done.dart';
import 'package:do_something/src/features/add_task/states/add_task_rating_state.dart';
import 'package:do_something/src/features/add_task/states/base_state.dart';
import 'package:do_something/src/features/add_task/states/mediator.dart';
import 'package:do_something/src/features/add_task/widgets/header.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> implements AddTaskMediator {
  @override
  Widget? childWidget;

  AddTaskBaseState get currentState => states[currentStateIndex];

  @override
  late TaskBuilder taskBuilder;

  late List<AddTaskBaseState> states;
  late int currentStateIndex;

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
    taskBuilder = TaskBuilder();

    _initState();
    transitionToNextState();
  }

  void _initState() {
    states = [
      AddTaskNameState(),
      AddTaskDetailsState(),
      AddTaskRatingState(),
      AddTaskOneTimeDoneState()
    ];
    currentStateIndex = -1;
  }

  @override
  void transitionToNextState() {
    if (currentStateIndex < states.length) {
      setState(() {
        currentStateIndex++;
        currentState.apply(this);
      });
    }
  }

  @override
  void transitionToPreviousState() {
    if (currentStateIndex > 0) {
      setState(() {
        currentStateIndex--;
        currentState.apply(this);
      });
    }
  }

  @override
  void setChildWidget(Widget childWidget) {
    setState(() {
      this.childWidget = childWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    // just a container with white background and a child is a header with back button and continue button
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(onBack: () {
                    _onBackButtonPressed(context);
                  }, onContinue: () {
                    _onContiueButtonPressed(context);
                  }),
                  childWidget != null
                      ? Expanded(child: childWidget!)
                      : const Spacer(),
                ],
              ),
            )));
  }
}
