import 'package:do_something/src/features/models/history_type.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef CallbackAction = void Function();

class TaskHistoryCell extends StatelessWidget {
  final DateTime logDate;
  final String? comment;
  final HistoryType eventType;
  final CallbackAction callbackAction;

  const TaskHistoryCell({
    Key? key,
    required this.logDate,
    required this.comment,
    required this.eventType,
    required this.callbackAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('MMM d, y h:mm a').format(logDate.toLocal()).toLowerCase();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        _buildText(context, formattedDate,
                            AppTheme.textStyle(context).bodySmall!),
                        const SizedBox(width: 8),
                        _historyTypeBuilder(context, eventType)
                      ],
                    ),
                    const SizedBox(height: 8),
                    _commentBuilder(context, comment),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  callbackAction();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Divider(
            color: AppTheme.appColors(context).secondary,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _commentBuilder(BuildContext context, String? comment) {
    if (comment == null) {
      return const SizedBox.shrink();
    }

    return _buildText(
        context,
        comment,
        AppTheme.textStyle(context)
            .bodySmall!
            .copyWith(color: AppTheme.appColors(context).onSecondary));
  }

  Widget _buildText(BuildContext context, String content, TextStyle style) {
    return Text(
      content,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: style,
    );
  }

  Widget _historyTypeBuilder(BuildContext context, HistoryType type) {
    switch (type) {
      case HistoryType.create:
        return _tagBuilder(
            context, 'creation', Colors.green[700]!, Colors.white);
      case HistoryType.update:
        return _tagBuilder(context, 'update', Colors.blue[700]!, Colors.white);
      case HistoryType.delete:
        return _tagBuilder(context, 'deletion', Colors.red[700]!, Colors.white);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _tagBuilder(
      BuildContext context, String tagName, Color background, Color textColor) {
    // container with rounded border with background color and text inside with text color
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _buildText(
        context,
        tagName,
        AppTheme.textStyle(context)
            .bodySmall!
            .copyWith(color: textColor, fontWeight: FontWeight.w300),
      ),
    );
  }
}
