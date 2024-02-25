import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

class DonateButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double? width; // 너비를 옵셔널로 받음
  final double? height; // 높이도 옵셔널로 받음

  const DonateButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    this.width, // 너비를 옵셔널로 받음
    this.height, //높이도 옵셔널로 받음
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 버튼 고정 너비, 높이 설정
    final buttonWidth = width ?? 200.0; // 기본 너비를 250.0으로 설정
    final buttonHeight = height ?? 64.0; // 기본 높이를 44.0으로 설정

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: PRIMARY_BLUE_COLOR, // 버튼 배경색 사용
        minimumSize: Size(buttonWidth, buttonHeight), // 동적으로 너비와 높이 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonName,
            style: TextStyle(
              color: Colors.white, // 버튼 텍스트 색상 사용
              fontWeight: FontWeight.w700,
              fontSize: 20,
            )
          ),
        ],
      ),
    );
  }
}
