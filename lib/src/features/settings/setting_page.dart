import 'package:do_something/src/features/settings/colorset_selector.dart';
import 'package:do_something/src/features/task/redux/task_actions.dart';
import 'package:do_something/src/features/task/redux/task_state.dart';
import 'package:do_something/src/features/task_history/modal_scaffold.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef CallbackAction = void Function(BuildContext context);

class SettingPage extends StatefulWidget {
  final Animation<double> animation;
  final CallbackAction onDismissed;

  const SettingPage({
    Key? key,
    required this.animation,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskState>(
        converter: (store) => store.state.taskState,
        builder: (context, taskState) {
          return ModalScaffold(
              animation: widget.animation,
              onDismissed: _onDismissed,
              child: ColorSetSelector(
                  colorSets: TaskColorSet.allSets,
                  selectedId: taskState.selectedColorSetId,
                  onColorSetSelected: _onColorSetSelected));
        });
  }

  void _onDismissed(BuildContext context) {
    Navigator.pop(context);
    widget.onDismissed(context);
  }

  void _onColorSetSelected(TaskColorSet? colorSet) {
    if (colorSet == null) return;

    var store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateColorSetAction(colorSet.id));
  }
}
