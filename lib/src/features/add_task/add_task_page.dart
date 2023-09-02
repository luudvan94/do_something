import 'package:do_something/src/features/add_task/widgets/header.dart';
import 'package:do_something/src/features/add_task/widgets/text_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  void _onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // just a container with white background and a child is a header with back button and continue button
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: [
                  Header(
                      onBack: () {
                        _onBackButtonPressed(context);
                      },
                      onContinue: () {}),
                  const Expanded(child: TextEditor()),
                ],
              ),
            )));
  }
}
