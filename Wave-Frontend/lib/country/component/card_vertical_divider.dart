import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

class CardVerticalDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CardVerticalDivider({
    Key? key,
    this.height = 70,
    this.color = BUTTON_BACKGROUND_COLOR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: height,
        width: 2,
        color: color,
      ),
    );
  }
}
