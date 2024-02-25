import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double iconSize; // 아이콘 크기를 위한 새 매개변수

  const CustomBackButton({
    Key? key,
    required this.onPressed,
    this.iconSize = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5.0,
      left: 5.0,
      child: SafeArea(
        child: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: onPressed,
          iconSize: iconSize,
        ),
      ),
    );
  }
}
