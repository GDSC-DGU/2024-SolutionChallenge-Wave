import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/common/view/initial_screen.dart';
import 'package:wave/common/view/root_tab.dart';
import 'package:wave/country/view/search_country_detail_screen.dart';
import 'package:wave/country/view/search_country_screen.dart';
import 'package:wave/country/view/donate_countries_screen.dart';
import 'package:wave/country/view/donate_country_detail_screen.dart';
import 'package:wave/main.dart';
import 'package:wave/map/view/wave_select_screen.dart';
import 'package:wave/onboarding/onboarding_screen.dart';
import 'package:wave/user/provider/user_me_provider.dart';
import 'package:wave/user/view/donate_completion_screen.dart';
import 'package:wave/user/view/login_screen.dart';
import 'package:wave/loading/loading_screen.dart';
import 'package:wave/user/view/my_page_screen.dart';
import '../../splash/splash_screen.dart';
import '../model/user_model.dart';
import 'package:wave/user/view/donation_list_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            GoRoute(
              path: 'donate',
              name: DonateCountriesScreen.routeName,
              builder: (_, __) => const DonateCountriesScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  name: DonateCountryDetailScreen.routeName,
                  builder: (_, state) => DonateCountryDetailScreen(
                    id: int.parse(
                      state.pathParameters['id']!,
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'search',
              name: SearchCountriesScreen.routeName,
              builder: (_, __) => const SearchCountriesScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  name: SearchCountryDetailScreen.routeName,
                  builder: (_, state) => SearchCountryDetailScreen(
                    id: int.parse(
                      state.pathParameters['id']!,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/onboarding',
          name: OnboardingScreen.routeName,
          builder: (_, __) => OnboardingScreen(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/loading',
          name: LoadingScreen.routeName,
          builder: (_, __) => const LoadingScreen(),
        ),
        GoRoute(
          path: '/donation-list',
          name: DonationListScreen.routeName,
          builder: (_, __) => const DonationListScreen(),
        ),
        GoRoute(
          path: '/myPage',
          name: MyPageScreen.routeName,
          builder: (_, __) => const MyPageScreen(),
        ),
      ];

  // SplashScreen
  // 앱을 처음 시작했을때
  // 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.matchedLocation == '/login';
    // SharedPreferences에서 isFirstRun 값을 가져옴
    final bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
    // 최초 실행이고 로그인 상태가 아니라면 온보딩 화면으로 리다이렉트
    if (isFirstRun && user == null) {
      return '/onboarding';
    }

    if (user == null) {
      return logginIn ? null : '/login';
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    if (user is UserModel &&
        (state.matchedLocation == '/onboarding' ||
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/splash')) return '/';

    return null;
  }
}
