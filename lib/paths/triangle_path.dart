import 'package:flutter/material.dart';

class TrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TriangleBorderPainter extends CustomPainter {
  double top;
  double left;
  double widgetSize;
  TriangleBorderPainter(
      {required this.left, required this.top, required this.widgetSize});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = const Color.fromARGB(255, 250, 246, 246);
    Path path = Path();
    path.moveTo(
      left + widgetSize / 2,
      top,
    );
    path.lineTo(left, top + widgetSize);
    path.lineTo(widgetSize + left, top + widgetSize);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TriangleImagePath extends CustomClipper<Path> {
  double top;
  double left;
  double widgetSize;
  TriangleImagePath(
      {required this.left, required this.top, required this.widgetSize});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(
      left + widgetSize / 2,
      top,
    );
    path.lineTo(left, top + widgetSize);
    path.lineTo(widgetSize + left, top + widgetSize);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
