import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

class CategoryButton extends StatelessWidget {
  final String category;

  const CategoryButton({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor = Colors.white;
    switch (category) {
      case 'EMERGENCY':
        backgroundColor = EMERGENCY_RED_COLOR;
        break;
      case 'ALERT':
        backgroundColor = ALERT_ORANGE_COLOR;
        break;
      case 'CAUTION':
        backgroundColor = CAUTION_YELLO_COLOR;
        textColor = Colors.black;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6,3, 10, 3),
        child: Text(
          category,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
