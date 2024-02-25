import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SmallButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback? onPressed;

  const SmallButton({
    Key? key,
    required this.svgPath,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white, // SVG 배경색 설정, 필요에 따라 조정
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          svgPath,
          fit: BoxFit.cover, // SVG를 컨테이너에 맞게 조정
        ),
      ),
    );
  }
}
