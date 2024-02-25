import 'package:flutter/material.dart';

class DonatedWavesSummary extends StatefulWidget {
  final int totalWave;

  const DonatedWavesSummary({
    Key? key,
    required this.totalWave,
  }) : super(key: key);

  @override
  DonatedWavesSummaryState createState() => DonatedWavesSummaryState();
}

class DonatedWavesSummaryState extends State<DonatedWavesSummary> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // 애니메이션 지속 시간 설정
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: widget.totalWave).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 00),
          child: SizedBox(
            width: 165.0,
            height: 40.0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E2E8).withOpacity(0.41),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  'Donated waves',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🌊 ${_animation.value}',
                  style: const TextStyle(
                    color: Color(0xFF247EF4),
                    fontWeight: FontWeight.w600,
                    fontSize: 48,
                  ),
                ),
                Text(
                  'Wave per 1USD / \$${widget.totalWave.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
