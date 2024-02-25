import 'package:flutter/material.dart';

class DonateCountryLabel extends StatelessWidget {
  final String countryName;

  const DonateCountryLabel({
    Key? key,
    required this.countryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          countryName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
