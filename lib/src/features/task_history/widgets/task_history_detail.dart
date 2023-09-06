import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef OnDismissed = void Function(BuildContext context);

class TaskHistoryDetail extends StatefulWidget {
  final OnDismissed onGoBack;

  const TaskHistoryDetail({
    Key? key,
    required this.onGoBack,
  }) : super(key: key);

  @override
  State<TaskHistoryDetail> createState() => _TaskHistoryDetailState();
}

class _TaskHistoryDetailState extends State<TaskHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.appColors(context).background.withOpacity(1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Back icon at the top
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    widget.onGoBack(context); // Execute the callback function
                  },
                ),
              ),
            ),
            // Your other widgets come here
          ],
        ),
      ),
    );
  }
}
