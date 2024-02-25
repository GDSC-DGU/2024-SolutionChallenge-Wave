import 'dart:async';
import 'package:flutter/material.dart';
import '../../discription/view/discription_screen.dart';

class CardSlider extends StatefulWidget {
  final List<String> imagePaths; // 이미지 경로 리스트를 받는 변수 추가

  CardSlider({Key? key, required this.imagePaths}) : super(key: key);

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  final PageController _pageController = PageController(viewportFraction: 1.04);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          width: 353,
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return Padding( // 여기에 패딩 추가
                padding: const EdgeInsets.symmetric(horizontal: 10), // 좌우 간격 설정
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiscriptionScreen(),
                    ),
                  ),
                  child: Image.asset(
                    widget.imagePaths[index],
                    width: 353,
                    height: 200,
                  ),
                ),
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.imagePaths.length, (index) {
            return Container(
              width: 7,
              height: 7,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Color(0xFF545454) : Color(0xFFD9D9D9),
              ),
            );
          }),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
