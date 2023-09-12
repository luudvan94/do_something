import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_something/main.dart';
import 'package:do_something/src/animations/fade_transition.dart';
import 'package:do_something/src/features/task/task_page.dart';
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<String> steps = [
    "Anki-driven scheduling. Tasks aligned with your frequency preference!",
    "Double-tap to mark tasks as done.",
    "Double-tap again to comment after completion.",
  ];
  int currentStep = 0;

  void _navigateToHomePage() {
    var box = Hive.box(appSettingBox);
    box.put(onBoardingKey, true);
    FadeInTransition.by(
        context, (context, animation, secondaryAnimation) => const TaskPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Top bar with progress and skip button.
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${currentStep + 1}/${steps.length}',
                    style: AppTheme.textStyle(context).bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      // Define your action when "Skip" is pressed.
                      _navigateToHomePage();
                    },
                    child: Text(
                      'Skip',
                      style: AppTheme.textStyle(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            // Spacer.
            const SizedBox(height: 20),
            // The text content.
            Expanded(
              child: Center(
                child: AutoSizeText(
                  steps[currentStep].toLowerCase(),
                  maxFontSize: 100,
                  minFontSize: 50,
                  style: AppTheme.textStyle(context).bodyMedium,
                ),
              ),
            ),
            // Button at the bottom.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  if (currentStep < steps.length - 1) {
                    setState(() {
                      currentStep++;
                    });
                  } else {
                    _navigateToHomePage();
                  }
                },
                child: Text(currentStep < steps.length - 1 ? 'next' : 'finish',
                    style: AppTheme.textStyle(context).bodyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
