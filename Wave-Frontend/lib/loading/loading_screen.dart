import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static const String routeName = '/loading';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Scaffold 배경을 투명하게 설정
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.white, // 전체 화면에 꽉 차는 반투명한 흰색 배경
              ),
            ),
          ),
          Center(
            child: Container(
              width: 100, // GIF 이미지의 크기 조절
              height: 100, // GIF 이미지의 크기 조절
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/images/loadingIndicator.gif',
                fit: BoxFit.contain, // 이미지가 컨테이너 안에 맞게 조절
              ),
            ),
          ),
        ],
      ),
    );
  }
}
