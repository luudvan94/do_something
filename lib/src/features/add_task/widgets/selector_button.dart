import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

typedef CallbackAction = void Function();

class SelectorButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final CallbackAction onSelected;

  const SelectorButton({
    Key? key,
    required this.label,
    required this.onSelected,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          logger.i('SelectorButton: onTap');
          onSelected();
        },
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? AppTheme.appColors(context).primary
                    : AppTheme.appColors(context).secondary,
                width: 1,
              ),
              color: isSelected
                  ? AppTheme.appColors(context).primary
                  : AppTheme.appColors(context).background,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: AnimatedDefaultTextStyle(
                style: isSelected
                    ? AppTheme.textStyle(context).bodyMedium!.copyWith(
                          color: AppTheme.appColors(context).onPrimary,
                        )
                    : AppTheme.textStyle(context).bodyMedium!,
                duration: const Duration(milliseconds: 100),
                child: AutoSizeText(
                  label,
                  maxFontSize: 100,
                  minFontSize: 32,
                  wrapWords: false,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ]));
  }
}
