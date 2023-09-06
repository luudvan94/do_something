import 'package:flutter/material.dart';

typedef DismissCallback = void Function(BuildContext context);

class ModalScaffold extends StatefulWidget {
  final Widget child;
  final Color spacerColor;
  final DismissCallback onDismissed;

  const ModalScaffold({
    Key? key,
    required this.child,
    this.spacerColor = Colors.transparent,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<ModalScaffold> createState() => _ModalScaffoldState();
}

class _ModalScaffoldState extends State<ModalScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.spacerColor,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              widget.onDismissed(context);
            },
            child: _buildSpacer(),
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  Widget _buildSpacer() {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      color: Colors.transparent,
    );
  }
}
