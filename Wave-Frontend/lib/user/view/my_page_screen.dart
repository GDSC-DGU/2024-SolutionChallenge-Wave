import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/onboarding/onboarding_screen.dart';
import 'package:wave/user/component/my_page_menu_list.dart';
import 'package:wave/user/component/my_page_user_card.dart';
import 'package:wave/user/component/show_confirmation_dialog.dart';
import 'package:wave/user/model/user_model.dart';
import 'package:wave/user/provider/user_me_provider.dart';
import 'package:wave/user/repository/user_me_repository.dart';
import '../../loading/loading_screen.dart';
import 'donation_list_screen.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  static String get routeName => 'myPage';
  const MyPageScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageScreen> {

  var amountBadge = "NONE";
  var countBadge = "NONE";


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      await ref.read(userMeProvider.notifier).getMe();
    } catch (error) {
      print("사용자 데이터를 가져오는 중 에러 발생: $error");
    }
  }


  // 로그아웃 API 호출 함수
  Future<void> _logout() async {
    try{
      await ref.read(userMeProvider.notifier).logout();
    }catch(error){
      print("로그아웃 에러 발생: $error");
    }
  }

// 회원 탈퇴 API 호출 함수
  Future<void> _unsubscribe() async {
    try{
      await ref.read(userMeProvider.notifier).signOut();
    }catch(error){
      print("회원탈퇴 에러 발생: $error");
    }
  }

  // URL을 열기 위한 함수
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }


  @override
  Widget build(BuildContext context) {
    final actions = {
      'Donation list': () {
        context.push(DonationListScreen.routeName);
      },
      'About Wave': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(showAppBar: true),
          ),
        );
        },
      'Terms and conditions': () => _launchURL('https://gusty-flock-5cd.notion.site/Terms-and-conditions-for-Wave-14c3fa62bc754673a4555c45dfd7916a?pvs=4'),
      'Privacy policy': () => _launchURL('https://gusty-flock-5cd.notion.site/Privacy-Policy-for-Wave-2e85cef8f08e4b5abfd329a92cdf8c1e?pvs=4'),
      'Unscribing membership': () => showConfirmationDialog(
        context,
        'Are you sure you want to leave?',
        'All your donation lists will disappear. Would that be okay with you?',
        _unsubscribe,
      ),
    };

    final userState = ref.watch(userMeProvider);
    UserModel? user;

    print('titi');

    if(userState is UserModel){
      user = userState;
    }

    if(user == null){
      return const LoadingScreen();
    }else {
      return DefaultLayout(
        onLogout: _logout,
          isMyPage: true,
          title: 'My Page',
        isSingleChildScrollViewNeeded: true,
          child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Donation Profile',
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                MyPageUserCard(user: user),
                const SizedBox(height: 24),
                MyPageMenuList(actions: actions),
                const SizedBox(height: 120),
              ],
            ),
          )
      );
    }
  }
}