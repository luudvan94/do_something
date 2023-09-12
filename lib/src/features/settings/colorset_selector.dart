import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class ColorSetSelector extends StatefulWidget {
  final String selectedId;
  final List<TaskColorSet> colorSets;
  final ValueChanged<TaskColorSet?> onColorSetSelected;

  const ColorSetSelector({
    Key? key,
    required this.selectedId,
    required this.colorSets,
    required this.onColorSetSelected,
  }) : super(key: key);

  @override
  _ColorSetSelectorState createState() => _ColorSetSelectorState();
}

class _ColorSetSelectorState extends State<ColorSetSelector> {
  String? _selectedColorSetId;

  @override
  void initState() {
    super.initState();

    _selectedColorSetId = widget.selectedId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appColors(context).background.withOpacity(1),
      child: ListView.builder(
        itemCount: widget.colorSets.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'select task color set',
                style: AppTheme.textStyle(context).headline3,
              ),
            );
          }

          var realIndex = index - 1;
          bool isSelected =
              _selectedColorSetId == widget.colorSets[realIndex].id;

          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorSetId = widget.colorSets[realIndex].id;
                  widget.onColorSetSelected(widget.colorSets[realIndex]);
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.appColors(context).onBackground
                        : Colors.transparent,
                    width: isSelected ? 8.0 : 0.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: widget.colorSets[realIndex].colorRatingMap.values
                      .map((taskColor) => Expanded(
                            child: Container(
                              color: taskColor.background,
                              height: isSelected
                                  ? 95
                                  : 100, // Adjust the height based on selection
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
