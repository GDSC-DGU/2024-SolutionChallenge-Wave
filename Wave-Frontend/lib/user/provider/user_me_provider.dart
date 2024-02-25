import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wave/common/const/data.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/common/secure_storage/secure_storage.dart';
import 'package:wave/country/repository/search_country_repository.dart';
import 'package:wave/user/model/donation_response_model.dart';
import 'package:wave/user/model/send_wave_model.dart';
import 'package:wave/user/model/user_model.dart';

import '../model/donation_model.dart';
import '../model/google_login_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userMeRepository = ref.watch(userMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);

    return UserMeStateNotifier(
      authRepository: authRepository,
      repository: userMeRepository,
      storage: storage,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  DonationResponseModel? donationResponse; // 기부 목록 정보를 저장하는 필드

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
     //logout();
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    print('startGetMe');

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();
    state = resp.data;
  }

  Future<void> postDonations(int id, int money) async {
    try {
      // // 로그인 로딩 상태로 변경
      // state = UserModelLoading();

      // AuthRepository의 googleLogin 메서드 호출
      final donationResponse =
          await repository.postDonations(SendWaveModel(
        id: id,
        money: money,
      ));

      if (donationResponse.success == true) {
        print('donation succeed!');
        return;
      }
    } catch (e) {
      // 예외 발생 시 로그인 실패 상태로 변경
      state = UserModelError(message: '기부에 실패했습니다.');
    }
  }

  // UserMeStateNotifier 클래스 내부에 추가
  Future<void> googleLogin(GoogleLoginModel googleLoginModel) async {
    try {
      // 로그인 로딩 상태로 변경
      state = UserModelLoading();

      // AuthRepository의 googleLogin 메서드 호출
      final loginResponse =
          await authRepository.googleLogin(googleLoginModel: googleLoginModel);

      if (loginResponse.data != null) {
        // 받은 토큰을 안전하게 저장
        await storage.write(
            key: REFRESH_TOKEN_KEY, value: loginResponse.data!.refreshToken);
        await storage.write(
            key: ACCESS_TOKEN_KEY, value: loginResponse.data!.accessToken);

        // 저장된 토큰을 이용하여 사용자 정보 가져오기
        final userResp = await repository.getMe();
        // 상태를 업데이트하고 사용자 정보 반환
        print('userResp.data: ${userResp.data}');
        print('userResp.data Without Null: ${userResp.data!}');
        state = userResp.data!;
        print('state: $state');
      } else {
        // 로그인 실패 상태로 변경
        state = UserModelError(message: 'Google 로그인에 실패했습니다.');
      }
    } catch (e) {
      // 예외 발생 시 로그인 실패 상태로 변경
      state = UserModelError(message: 'Google 로그인에 실패했습니다.');
    }
  }

  Future<void> logout() async {
    state = null;
    await authRepository.logout();
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }

  Future<CommonResponse> signOut() async {
    state = null;
    // 토큰 삭제
    try {
      final resp = await authRepository.signOut();
      print('성공적 탈퇴');
      await Future.wait([
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ]);
      return resp;
    } catch (e) {
      print('signoutError?');
      throw e;
    }
  }
}
