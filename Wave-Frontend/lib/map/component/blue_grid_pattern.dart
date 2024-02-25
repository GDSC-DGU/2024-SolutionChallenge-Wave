import 'package:flutter/material.dart';

class BlueGridPattern extends StatelessWidget {
  final double zoomLevel;

  const BlueGridPattern({Key? key, required this.zoomLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(zoomLevel: zoomLevel),
    );
  }
}

class GridPainter extends CustomPainter {
  final double zoomLevel;

  GridPainter({required this.zoomLevel});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // zoomLevel에 따라 격자 간격을 조절
    double gridSpace = 45 * zoomLevel;

    // 격자를 그림
    for (double i = 0; i < size.width; i += gridSpace) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += gridSpace) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    // zoomLevel이 변경되었는지 여부에 따라 다시 그릴지 결정
    return oldDelegate.zoomLevel != zoomLevel;
  }
}