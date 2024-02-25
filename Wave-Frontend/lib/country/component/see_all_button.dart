import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SeeAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const SeeAllButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 여기서 받은 onTap 콜백을 사용
      child: Row(
        mainAxisSize: MainAxisSize.min, // 자식들의 크기에 맞게 Row의 크기를 조절
        children: [
          Text(
            'See all',
            style: TextStyle(
              color: Colors.grey, // 옅은 회색으로 변경
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 4), // 텍스트와 아이콘 사이 간격 추가
          SvgPicture.asset(
            'assets/icons/seeAll.svg',
            color: Colors.grey, // SVG 아이콘도 옅은 회색으로 변경
          ),
        ],
      ),
    );
  }
}
