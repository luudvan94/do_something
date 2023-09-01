import 'package:do_something/src/features/task/app_colors.dart';
import 'package:do_something/src/features/task/app_theme.dart';
import 'package:do_something/src/features/task/task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(primaryColor: AppColors.systemWhite),
      home: TaskPage(),
    );
  }
}
