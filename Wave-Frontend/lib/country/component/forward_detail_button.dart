import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';

class ForwardDetailButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final bool? isSearch;

  const ForwardDetailButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    this.width,
    this.height,
    this.isSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? 300.0;
    final buttonHeight = height ?? 54.0;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: BUTTON_BACKGROUND_COLOR,
        minimumSize: Size(buttonWidth, buttonHeight),
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
              color: BUTTON_TEXT_COLOR, // 버튼 텍스트 색상 사용
              fontWeight: FontWeight.w500,
              fontSize: isSearch == true ? 16 : 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SvgPicture.asset(
              'assets/icons/rightArrow.svg',
              height: isSearch == true ? 16 : 18,
            ),
          ),
        ],
      ),
    );
  }
}
