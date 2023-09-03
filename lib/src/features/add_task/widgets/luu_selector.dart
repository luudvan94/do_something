import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_something/src/features/add_task/widgets/selector_button.dart';
import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/utils/logger.dart';
import 'package:flutter/material.dart';

typedef LabelAction = String Function<T extends Identifiable>(T);
typedef OnSelectedAction = void Function<T extends Identifiable>(T);

class LuuSelector<T extends Identifiable> extends StatefulWidget {
  final List<Identifiable> items;
  final LabelAction getLabel;
  final OnSelectedAction onSelected;
  final bool isMultipleSelection;
  final Set<Identifiable> selectedItems;

  const LuuSelector({
    Key? key,
    required this.items,
    required this.getLabel,
    required this.onSelected,
    this.selectedItems = const {},
    this.isMultipleSelection = false,
  }) : super(key: key);

  @override
  _LuuSelectorState createState() => _LuuSelectorState();
}

class _LuuSelectorState<T extends Identifiable> extends State<LuuSelector> {
  late Set<Identifiable> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedItems;
    logger.i('LuuSelector.initState: selectedItems: $selectedItems');
  }

  @override
  Widget build(BuildContext context) {
    // container with blue background color
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: AutoSizeText('how you like that?',
                  maxLines: 1, style: AppTheme.textStyle(context).headline2)),
          ...widget.items
              .map((item) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: SelectorButton(
                    label: widget.getLabel(item),
                    onSelected: () {
                      setState(() {
                        if (widget.isMultipleSelection) {
                          if (selectedItems.contains(item)) {
                            selectedItems.remove(item);
                          } else {
                            selectedItems.add(item);
                          }
                        } else {
                          selectedItems.clear();
                          selectedItems.add(item);
                        }
                      });
                      widget.onSelected(item);
                    },
                    isSelected: selectedItems.contains(item),
                  )))
              .toList()
        ]);
  }
}
