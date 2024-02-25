import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:wave/map/model/wave_select_country.dart';

class CountryPainter extends CustomPainter {
  final List<WaveSelectCountryModel> countries;

  CountryPainter({required this.countries});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path allPaths = Path(); // 모든 경로를 저장할 Path 객체

    for (var country in countries) {
      // 각 국가의 경로를 Path 객체로 변환하고 allPaths에 추가
      var path = parseSvgPathData(country.path);
      allPaths.addPath(path, Offset.zero); // Offset.zero를 사용하여 원본 위치에 경로 추가
    }

    // 모든 경로를 포함하는 allPaths의 경계를 계산
    Rect bounds = allPaths.getBounds();

    // 캔버스의 중앙과 SVG의 중앙 사이의 차이를 계산하여 SVG를 캔버스 중앙에 배치
    double offsetX = size.width / 2 - bounds.center.dx;
    double offsetY = size.height / 2 - bounds.center.dy;

    canvas.translate(offsetX, offsetY); // 캔버스 시작 위치를 조정

    // 조정된 위치에서 모든 경로를 그림
    for (var country in countries) {
      paint.color = Color(int.parse("0xFF${country.color}"));
      var path = parseSvgPathData(country.path);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}