import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Divider(
        color: Colors.black.withOpacity(0.1),
        thickness: 1.5, // 굵기 설정
      ),
    );
  }
}

class CustomDividerSliver extends StatelessWidget {
  const CustomDividerSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: CustomDivider(),
    );
  }
}

class CustomDividerNoLine extends StatelessWidget {
  const CustomDividerNoLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 58.0),
    );
  }
}

class CustomDividerNoLinerSliver extends StatelessWidget {
  const CustomDividerNoLinerSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomDividerNoLine(),
    );
  }
}
