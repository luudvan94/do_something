import 'package:flutter/material.dart';

class DragClipper extends CustomClipper<Path> {
  final Offset offset;

  DragClipper({required this.offset});

  @override
  Path getClip(Size size) {
    final path = Path();

    // Define the path
    path.moveTo(0, 0);
    path.cubicTo(offset.dx, offset.dy, offset.dx, offset.dy, 0, size.height);
    path.lineTo(size.width, size.height);
    path.cubicTo(size.width - offset.dx, offset.dy, size.width - offset.dx,
        offset.dy, size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
