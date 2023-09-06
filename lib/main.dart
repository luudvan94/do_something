import 'package:do_something/src/theme/app_theme.dart';
import 'package:do_something/src/redux/init_redux.dart';
import 'package:do_something/src/features/task/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() async {
  var store = await initializeRedux();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({Key? key, required this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: AppTheme.themeData,
          darkTheme: AppTheme.darkThemeData,
          home: const TaskPage(),
        ));
  }
}
