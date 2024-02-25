import 'dart:ui';
import 'package:flutter/material.dart';

class TranslucenceCategoryButton extends StatelessWidget {
  final String text;

  const TranslucenceCategoryButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 첫 글자를 대문자로, 나머지는 소문자로 변환
    String formattedText = text.length > 1
        ? text[0].toUpperCase() + text.substring(1).toLowerCase()
        : text.toUpperCase();

    return IntrinsicWidth(
      child: ClipRRect( // 블러 효과를 위한 ClipRRect
        borderRadius: BorderRadius.circular(7), // 테두리 둥근 정도
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5), // 블러 효과 적용
          child: Container(
            height: 27, // 고정 높이
            padding: EdgeInsets.symmetric(horizontal: 18), // 텍스트 양옆의 여백
            decoration: BoxDecoration(
              color: Color(0xFFE2E2E8).withOpacity(0.3), // 배경색과 투명도
              borderRadius: BorderRadius.circular(7), // 테두리 둥근 정도 재적용
            ),
            child: Center(
              child: Text(
                formattedText,
                style: TextStyle(
                  color: Colors.white, // 텍스트 색상
                  fontSize: 14, // 텍스트 크기
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
