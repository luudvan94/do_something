import 'package:flutter/material.dart';

typedef DismissCallback = void Function(BuildContext context);

class ModalScaffold extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;
  final DismissCallback onDismissed;

  const ModalScaffold({
    Key? key,
    required this.child,
    required this.animation,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<ModalScaffold> createState() => _ModalScaffoldState();
}

class _ModalScaffoldState extends State<ModalScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            color: Colors.black87.withOpacity(0.5),
          ),
          SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(widget.animation),
              child: Container(
                color: Colors.transparent,
                child: Column(
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
              ))
        ]));
  }

  Widget _buildSpacer() {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      color: Colors.transparent,
    );
  }
}
