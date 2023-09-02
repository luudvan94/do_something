import 'package:do_something/auto_size_text_field.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({Key? key}) : super(key: key);

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // container with blue background color and full size
    return Container(
        color: Colors.transparent,
        child: Expanded(
          child: AutoSizeTextField(
            controller: _controller,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: 'what do you want to do',
              hintStyle: AppTheme.textStyle(context).headline1,
              border: InputBorder.none,
              isDense: true,
            ),
            minFontSize: 70,
            fullwidth: true,
            style: AppTheme.textStyle(context).headline1,
            textAlign: TextAlign.left,
            minLines: 1,
            maxLines: 10,
            wrapWords: true,
          ),
        ));
  }
}
