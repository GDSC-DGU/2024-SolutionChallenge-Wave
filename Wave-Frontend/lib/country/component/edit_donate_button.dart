import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditDonateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditDonateButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/images/donateEditButton.svg',
        width: 35,
        height: 35,
      ),
      onPressed: onPressed,
    );
  }
}
