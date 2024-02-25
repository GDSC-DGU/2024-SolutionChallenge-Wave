import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/google_login_model.dart';
import '../provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/loginBackground.png', // 배경 이미지 경로
              fit: BoxFit.cover, // 화면을 꽉 채우도록 설정
            ),
          ),
          // 로고 이미지와 로그인 버튼을 포함한 Column
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/images/loginScreenLogo.png", // 로고 이미지 경로
                    width: 239, // 로고 너비 설정
                    height: 99, // 로고 높이 설정
                  ),
                ),
              ],
            ),
          ),
          // 로그인 버튼을 하단에서 50px 위에 위치시키기
          Positioned(
            bottom: 90,
            left: 20,
            right: 20,
            child: InkWell(
              onTap: signInWithGoogle,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/google.svg",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          // GoogleLoginModel 생성
          final googleLoginModel = GoogleLoginModel(
            id: value.user!.uid,
            displayName: value.user!.displayName ?? 'NO NAME',
          );

          // UserMeStateNotifier를 통해 googleLogin 호출
          await ref.read(userMeProvider.notifier).googleLogin(googleLoginModel);
        }
      }).catchError((error) {
        print(error);
      });
    }
  }
}
