import 'package:do_something/src/features/add_task/widgets/text_editor.dart';
import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/features/models/task_history.dart';
import 'package:do_something/src/features/task_history/modal_scaffold.dart';
import 'package:do_something/src/features/task_history/redux/task_history_actions.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef CallbackAction = void Function(BuildContext);

class AddTaskCommentPage extends StatefulWidget {
  final TaskHistory history;
  final Animation<double> animation;
  final CallbackAction onDismissed;

  const AddTaskCommentPage({
    Key? key,
    required this.history,
    required this.animation,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<AddTaskCommentPage> createState() => _AddTaskCommentPageState();
}

class _AddTaskCommentPageState extends State<AddTaskCommentPage> {
  String currentValue = '';

  @override
  void initState() {
    super.initState();
    currentValue =
        (widget.history.details as HistoryTypeCompleteDetails).comment ?? '';
  }

  void _onDismissed(BuildContext context) {
    Navigator.pop(context);
    widget.onDismissed(context);
  }

  @override
  Widget build(BuildContext context) {
    return ModalScaffold(
        animation: widget.animation,
        onDismissed: _onDismissed,
        child: Container(
          color: AppTheme.appColors(context).background,
          child: Column(children: [
            _buildHeader(context),
            Flexible(
              fit: FlexFit.loose,
              child: _buildEditor(context),
            )
          ]),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .end, // This will place the items at the start and end of the row.
        children: [
          TextButton(
            onPressed: () {
              _onSubmitted(currentValue);
              _onDismissed(context);
            },
            child: Text('Done'),
          )
        ],
      ),
    );
  }

  Widget _buildEditor(BuildContext context) {
    return TextEditor(
        key: const Key('add_task_comment_text_editor'),
        value: currentValue,
        placeholder: 'enter comment',
        onSubmitted: _onSubmitted,
        onChanged: _onChanged);
  }

  void _onSubmitted(String value) {
    logger.i('Submitted: $value');
    (widget.history.details as HistoryTypeCompleteDetails).comment = value;

    var store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateTaskHistoryAction(widget.history));
  }

  void _onChanged(String value) {
    setState(() {
      currentValue = value;
    });
  }
}
