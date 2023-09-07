// Package imports
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

// Project imports
import 'package:do_something/auto_size_text_field.dart';
import 'package:do_something/src/theme/app_theme.dart';

// Meaningful constants
const double minFontSize = 30;
const int minLines = 1;
const int maxLines = 10;

typedef CallbackAction = void Function(String);

class TextEditor extends StatefulWidget {
  final String placeholder;
  final String value;
  final CallbackAction onSubmitted;
  final CallbackAction? onChanged;

  const TextEditor({
    Key? key,
    required this.value,
    required this.placeholder,
    required this.onSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.value.isNotEmpty) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: AutoSizeTextField(
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: AppTheme.textStyle(context).headlineMedium,
                  border: InputBorder.none,
                  isDense: true,
                ),
                maxLines: maxLines,
                minFontSize: minFontSize,
                minLines: minLines,
                fullwidth: true,
                style: AppTheme.textStyle(context).headlineMedium,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.done,
                wrapWords: true,
                onChanged: (value) {
                  widget.onChanged!(value);
                },
                onSubmitted: (value) {
                  widget.onSubmitted(value);
                },
              ),
            )
          ],
        ));
  }
}
