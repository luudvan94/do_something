import 'package:do_something/src/features/onboarding/onbaording_page.dart';
import 'package:do_something/src/features/task/task_page.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';

var appSettingBox = 'appSettingBox';
var onBoardingKey = 'onBoardingKey';

void main() async {
  var store = await initializeRedux();
  var box = await Hive.openBox(appSettingBox);
  var isOnboarded = box.get(onBoardingKey, defaultValue: false);
  runApp(MyApp(
    store: store,
    isOnboarded: isOnboarded,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final bool isOnboarded;
  const MyApp({Key? key, required this.store, this.isOnboarded = false})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: AppTheme.themeData,
          darkTheme: AppTheme.darkThemeData,
          home: isOnboarded ? const TaskPage() : const OnBoardingPage(),
        ));
  }
}
