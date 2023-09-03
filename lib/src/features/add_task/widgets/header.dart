import 'package:flutter/material.dart';

typedef CallbackAction = void Function();

class Header extends StatelessWidget {
  final CallbackAction onBack;
  final CallbackAction onContinue;
  final IconData backIcon;
  final IconData continueIcon;

  const Header({
    Key? key,
    required this.onBack,
    required this.onContinue,
    this.backIcon = Icons.arrow_back_ios,
    this.continueIcon = Icons.arrow_forward_ios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button
        IconButton(
          onPressed: () {
            onBack();
          },
          icon: Icon(backIcon),
        ),
        // Continue button
        IconButton(
          onPressed: () {
            onContinue();
          },
          icon: Icon(continueIcon),
        ),
      ],
    );
  }
}
