import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/common/provider/go_router.dart';
import 'package:wave/map/view/global_map_screen.dart';
import 'package:wave/map/view/wave_select_screen.dart';
import 'package:wave/onboarding/onboarding_screen.dart';
import 'package:wave/payment/services/mock_server.dart';
import 'package:wave/user/view/badge_congrats_screen.dart';
import 'package:wave/user/view/badge_screen.dart';
import 'package:wave/user/view/donate_completion_screen.dart';
import 'package:wave/user/view/donation_list_screen.dart';
import 'package:wave/user/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wave/user/view/my_page_screen.dart';
import 'discription/view/discription_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'loading/loading_screen.dart';
import 'payment/models/payment_request.dart';

// 전역 변수로 쓰기 위해, 메인함수 밖에서 사용해주었다.
late SharedPreferences prefs;

//⭐️ 아래에 스크린 UI 빌딩 빠르게 볼 수 있는 주석 코드 있음 ⭐️
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MockServer.startServer();
  // 온보딩 화면을 보여주기 위해, 최초 실행 여부를 확인
  prefs = await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: _App()));
}


class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

extension PaymentRequestExtension on PaymentRequest {
  Uri get url {
    // TODO 토스페이를 위해 만든 Web 주소를 넣어주세요. 아래는 예시입니다. => Test이므로, 예제 그대로 8080
    return Uri.http("localhost:8080", "payment", json);
  }
}

// //// ⭐️ TEST CODE: 아래처럼 UI만 보고 싶을 때 위에 기존거 주석 처리 하고 ✅
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     ProviderScope( // ProviderScope 추가
//       child: _App(),
//     ),
//   );
// }
//
// class _App extends StatelessWidget {
//   const _App({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Pretendard',
//       ),
//       debugShowCheckedModeBanner: false,
//       home: BadgeCongratsScreen(count: "100", amount: "1000",), // 여기 원하는 스크린 대입 ✅
//     );
//   }
// }

