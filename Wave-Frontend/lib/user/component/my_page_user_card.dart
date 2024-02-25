import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/user/model/user_model.dart';
import 'package:wave/user/component/show_confirmation_dialog.dart';
import 'package:wave/user/view/badge_congrats_screen.dart';
import 'package:wave/user/view/badge_screen.dart';

import 'my_page_components.dart';

class MyPageUserCard extends StatelessWidget {
  final UserModel user;

  const MyPageUserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: PRIMARY_BLUE_COLOR,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  user.nickname,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {
                  // BadgeScreen으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BadgeScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/icons/myBadgeButton.png', // SVG 파일의 경로
                  width: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF242424), // 내부 박스 색상 변경
              borderRadius: BorderRadius.circular(15),
            ),
            child: buildInfoSection(user.totalWave, user.donationCountryCnt),
          )
        ],
      ),
    );
  }
}
