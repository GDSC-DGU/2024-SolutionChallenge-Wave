import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/layout/default_layout.dart';

class DiscriptionScreen extends ConsumerStatefulWidget {
  const DiscriptionScreen({Key? key}) : super(key: key);

  static const String routeName = '/discription';

  @override
  ConsumerState<DiscriptionScreen> createState() => _DiscriptionScreenState();
}

class _DiscriptionScreenState extends ConsumerState<DiscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView 내부에 Padding을 적용
    return DefaultLayout(
      isNeededCenterAppbar: true,
      title: 'What we can do',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // 여기서 패딩 값을 조정할 수 있습니다.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 내용을 중앙에 정렬
            children: [
              SizedBox(height: 20), // 첫 번째와 두 번째 이미지 사이의 간격
              Image.asset('assets/images/discriptionCard1.png'), // 첫 번째 이미지
              SizedBox(height: 30), // 첫 번째와 두 번째 이미지 사이의 간격
              Image.asset('assets/images/discriptionCard2.png'), // 두 번째 이미지
              SizedBox(height: 30), // 두 번째와 세 번째 이미지 사이의 간격
              Image.asset('assets/images/discriptionCard3.png'), // 세 번째 이미지
            ],
          ),
        ),
      ),
    );
  }
}
