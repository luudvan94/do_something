import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef CallbackAction = void Function(BuildContext context);

class TaskHistoryPage extends StatefulWidget {
  final Animation<double> animation;
  final CallbackAction onDismissed;

  const TaskHistoryPage(
      {Key? key, required this.animation, required this.onDismissed})
      : super(key: key);

  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(widget.animation),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                widget.onDismissed(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                color: Colors.transparent,
              ),
            ),
            Expanded(
              child: Container(
                color: AppTheme.appColors(context).background.withOpacity(1),
                child: Center(
                  child: Text('Task History',
                      style: Theme.of(context).textTheme.headline1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
