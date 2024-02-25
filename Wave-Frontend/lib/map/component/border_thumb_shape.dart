import 'package:flutter/material.dart';

class BorderThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const BorderThumbShape({this.thumbRadius = 16.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final Paint thumbInnerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint thumbBorderPaint = Paint()
      ..color = Color(0xFF247EF4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Thumb의 내부
    canvas.drawCircle(center, thumbRadius - thumbBorderPaint.strokeWidth, thumbInnerPaint);
    // Thumb의 테두리
    canvas.drawCircle(center, thumbRadius, thumbBorderPaint);
  }
}


class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? sliderTheme.thumbColor! // activeTrackColor를 우선 사용하고, 없을 경우 thumbColor를 사용
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}

