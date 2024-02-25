import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/main.dart';
import '../user/view/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static String get routeName => 'onboarding';
  final bool showAppBar;

  OnboardingScreen({Key? key, this.showAppBar = false}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    prefs.setBool('isFirstRun', false);
    super.initState();
  }

  // 타이틀과 내용
  final List<Map<String, String>> pageData = [
    {
      'title': 'We are a wave',
      'content': 'Create positive ripples in the world.',
    },
    {
      'title': 'Our Goals',
      'content': 'We remind people of the severity of war and provide solutions to help refugees through donations.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    print('Is AppBar supposed to show? ${widget.showAppBar}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppBar
          ? _buildAppBar()
          : null,
      body: Stack(
        children: [
          Padding(
            padding: widget.showAppBar
                ? const EdgeInsets.only(bottom: 50)
                : const EdgeInsets.only(bottom: 50, top: 90),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pageData[_currentPage]['title'] ?? '',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          pageData[_currentPage]['content'] ?? '',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Image.asset('assets/images/onBoardingImage1.png',
                      ),
                      Image.asset('assets/images/onBoardingImage2.png',

                      ),
                    ],
                  ),
                ),
                // 인디케이터 고정
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) => _buildIndicator(index)),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          if (!widget.showAppBar)
            Positioned(
            top: 50.0,
            left: 8.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.transparent, // 배경을 투명하게 설정
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: PRIMARY_BLUE_COLOR,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        'About Wave',
        style: TextStyle(

          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.9),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
        iconSize: 24,
      ),
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}