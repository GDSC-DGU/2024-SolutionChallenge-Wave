import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/custom_animation_nav_bar.dart';
import 'package:wave/country/view/search_country_screen.dart';
import 'package:wave/country/view/donate_countries_screen.dart';
import 'package:wave/map/view/global_map_screen.dart';
import 'package:wave/user/view/my_page_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;
  GlobalKey<CurvedNavigationBarState> navigationKey = GlobalKey();

  final screens = [
    GlobalMapScreen(),
    const DonateCountriesScreen(),
    const SearchCountriesScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = List<Widget>.generate(4, (index) {
      String iconName =
          'tab${index + 1}${this.index == index ? 'On' : 'Off'}.svg';
      return SvgPicture.asset('assets/icons/$iconName');
    });

    return Scaffold(
      body: screens[index],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20), // 하단에서 20px만큼 띄우기
        child: SafeArea(
          child: Container(
            height: 70,
            child: CustomAnimationNavBar(
              key: navigationKey, // key를 할당
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 700),
              backgroundColor: PRIMARY_BLUE_COLOR,
              buttonBackgroundColor: PRIMARY_BLUE_COLOR,
              height:70,
              index: index,
              color: Color(0xFF242424),
              onTap: (selectedIndex) {
                setState(() {
                  index = selectedIndex;
                });
              },
              items: items,
            ),
          ),
        ),
      ),
    );
  }
}
