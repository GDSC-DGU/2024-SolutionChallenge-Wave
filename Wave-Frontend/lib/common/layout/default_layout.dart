import 'package:flutter/material.dart';
import 'package:wave/user/provider/user_me_provider.dart';

import '../../user/component/show_confirmation_dialog.dart';

class DefaultLayout extends StatelessWidget {
  final VoidCallback? onLogout;
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool isSingleChildScrollViewNeeded; // Make it non-optional with a default value
  final bool isNeededCenterAppbar;
  final bool isMyPage; // MyPage 여부를 나타내는 새로운 파라미터


  const DefaultLayout({
    this.onLogout,
    required this.child,
    this.backgroundColor = const Color(0xFFFFFFFF), // 기본 배경색을 흰색으로 설정
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.isSingleChildScrollViewNeeded = false, // Default to false
    this.isNeededCenterAppbar = false,
    this.isMyPage = false, // 기본값을 false로 설정
    Key? key,
    AppBar? appBar,
  }) : super(key: key);

  // // 로그아웃 API 호출 함수
  // Future<void> _logout() async {
  //   try{
  //     await ref.read(userMeProvider.notifier).logout();
  //   }catch(error){
  //     print("로그아웃 에러 발생: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: renderAppBar(context),
      body: isSingleChildScrollViewNeeded
          ? SingleChildScrollView(child: child) // Wrap child with SingleChildScrollView if needed
          : child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title == null) {
      return null;
    } else if (isNeededCenterAppbar){
      return AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
            title!,
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
    else {
      return AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: <Widget>[
          if (isMyPage && onLogout != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0), // 오른쪽에 8.0의 패딩 추가
              child: OutlinedButton(
                onPressed: () {
                  if (onLogout != null) {
                    showConfirmationDialog(
                      context,
                      'Do you want to logout?',
                      'You will be returned to the login screen.',
                      onLogout!,
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black.withOpacity(0.9), width: 1.2),
                  minimumSize: const Size(80, 30),
                ),
                child: Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      );
    }
  }
}
