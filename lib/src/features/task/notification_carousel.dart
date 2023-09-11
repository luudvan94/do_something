import 'dart:async';
import 'package:do_something/src/features/models/task.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class NotificationCarousel extends StatefulWidget {
  final Task? currentTask;
  final int numberOfDoneTimes;
  final TaskColor currentTaskColor;

  NotificationCarousel({
    required this.currentTask,
    required this.numberOfDoneTimes,
    required this.currentTaskColor,
  });

  @override
  _NotificationCarouselState createState() => _NotificationCarouselState();
}

class _NotificationCarouselState extends State<NotificationCarousel>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _currentNotification = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _fadeController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _fadeController.forward();
        }
      });

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeController);

    _fadeController.forward();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentNotification < notifications.length - 1) {
        _currentNotification++;
      } else {
        _currentNotification = 0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  List<String> get notifications {
    var lastIgnore =
        'this is the last time this task will be displayed for today';
    var complete = 'double-tap to mark this task as complete';
    var comment = 'double-tap to add comment for this completion';

    List<String> notes = [];
    if (widget.currentTask?.ignoreCountLeft == 1) {
      notes.add(lastIgnore);
    }

    if (widget.numberOfDoneTimes < 20) {
      if (widget.currentTask?.reviewDate.isBefore(DateTime.now()) == true) {
        notes.add(complete);
      } else {
        notes.add(comment);
      }
    }

    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Text(
          notifications[_currentNotification],
          textAlign: TextAlign.center,
          style: AppTheme.textStyle(context).bodySmall!.copyWith(
                color: widget.currentTaskColor.foreground,
              ),
        ),
      ),
    );
  }
}
