import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wave/user/provider/user_me_provider.dart';

import '../../user/provider/auth_provider.dart';
import '../const/data.dart';
import '../secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(
      storage: storage,
      ref: ref,
    ),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  // 1) 요청을 보낼때
  //요청이 보내질때마다 만약 요청의 Header에 accessToken : true 라는 값이 있다면?
  //storage에서 실제토큰을 가져와서 authorization: Bearer $token으로 헤더변경한다
  // 왜 이렇게 해?🤔 -> Auth API Call마다, accessToken 매번 넣어주는 귀찮은 일 할 필요없음
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      print('accessToken: $token');
      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    print('Data: ${response.data}');
    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때(어떤 상황 캐치하고 싶은지 분기처리가 중요함)
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // ex)
    // 401에러 났을때(토큰 만료, 토큰 오타, status code)
    // 토큰 재발급 받는 시도하고 토큰이 재발급되면
    // 다시 새로운 토큰 요청
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    //refreshToken 아예 없으면 당연히 에러 던진다
    if (refreshToken == null) {
      //에러 던질때는 reject 사용
      print('refreshNull?');
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/refresh';

    /// 토큰 재발급 요청

    // 토큰을 refresh하려는 의도가 아니었는데 401에러가 났다면?(401 -> token 만료)
    if (isStatus401&& !isPathRefresh) {
      final dio = Dio();
      try {
        print('token refresh start');
        final resp = await dio.post(
          '$ip/api/v1/auth/refresh',
          options: Options(
            headers: {
              'Authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final newAccessToken = resp.data['data']['accessToken'];

        print('NEW NEW NEW! $accessToken');

        final options = err.requestOptions; //요청을보낼때 필요한 모든값은 equestOptions에 잇다


        options.headers.addAll({
          'authorization': 'Bearer $newAccessToken',
        });

        //storage 업데이트 당연히 필요
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        //요청 재전송(원래 요청을 토큰만 변경시킨채로 다시보냄)
        final response = await dio.fetch(options);

        return handler.resolve(response); //외부에서는 이 과정만보임 (요청이 잘 끝났음 의미)
      } on DioError catch (e) {
        print('DioError Occurred Error Reason: ${e.message}');
        ref.read(userMeProvider.notifier).logout();
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
