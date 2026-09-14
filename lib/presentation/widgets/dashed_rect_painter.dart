import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;

  DashRectPainter({
    this.strokeWidth = 5.0,
    this.color = Colors.red,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final x = size.width;
    final y = size.height;

    final topPath = getDashedPath(
      a: const math.Point(0.0, 0.0),
      b: math.Point(x, 0.0),
      gap: gap,
    );

    final rightPath = getDashedPath(
      a: math.Point(x, 0.0),
      b: math.Point(x, y),
      gap: gap,
    );

    final bottomPath = getDashedPath(
      a: math.Point(0.0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    final leftPath = getDashedPath(
      a: const math.Point(0.0, 0.0),
      b: math.Point(0.0, y),
      gap: gap,
    );

    canvas.drawPath(topPath, dashedPaint);
    canvas.drawPath(rightPath, dashedPaint);
    canvas.drawPath(bottomPath, dashedPaint);
    canvas.drawPath(leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required double gap,
  }) {
    final size = Size(b.x - a.x, b.y - a.y);
    final path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    var currentPoint = math.Point(a.x, a.y);

    final radians = math.atan(size.height / size.width);

    final dx = (math.cos(radians) * gap).abs();
    final dy = (math.sin(radians) * gap).abs();

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(DashRectPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.gap != gap;
  }
}
