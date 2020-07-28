import 'package:flutter/material.dart';

class SlicePainter extends CustomPainter {
  List<Offset> pointsList;
  SlicePainter({this.pointsList});

  final Paint paintObject = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    _drawPath(canvas);
  }

  void _drawPath(Canvas canvas) {
    Path path = Path();

    paintObject.color = Colors.white;
    paintObject.strokeWidth = 3;
    paintObject.style = PaintingStyle.fill;

    if (pointsList.length < 2) return;

    paintObject.style = PaintingStyle.stroke;
    path.moveTo(pointsList[0].dx, pointsList[0].dy);

    for (int i = 1; i < pointsList.length; i++) {
      if (pointsList[i] == null) {
        continue;
      }
      path.lineTo(pointsList[i].dx, pointsList[i].dy);
    }

    canvas.drawPath(path, paintObject);
  }

  @override
  bool shouldRepaint(SlicePainter oldDelegate) => true;
}
