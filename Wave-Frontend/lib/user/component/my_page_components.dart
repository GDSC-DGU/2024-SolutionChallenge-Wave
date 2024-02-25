import 'package:flutter/material.dart';

Widget buildInfoSection(int totalWave, int donationCountryCnt) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildInfoText('🌊 $totalWave', 'Delivered waves', 'Wave per 1USD / ${totalWave.toStringAsFixed(2)}'),
          const VerticalDivider(color: Colors.white),
          buildInfoText('🌍 $donationCountryCnt', 'Protected countries', ''),
        ],
      ),
    ),
  );
}

Widget buildInfoText(String value, String label, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white)),
      Text(description, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w300, color: Colors.white)),
      const SizedBox(height: 10),
    ],
  );
}