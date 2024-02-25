import 'package:flutter/material.dart';

class RiskLevelButton extends StatelessWidget {
  final String riskLevel;
  final bool isSelected;
  final Color color;
  final VoidCallback onPressed;

  const RiskLevelButton({
    Key? key,
    required this.riskLevel,
    required this.isSelected,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(riskLevel),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? color : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
