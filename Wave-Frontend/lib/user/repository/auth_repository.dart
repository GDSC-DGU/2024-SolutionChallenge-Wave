import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/common/model/login_response.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/google_login_model.dart';
part 'auth_repository.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio, baseUrl: '$ip/api/v1/auth');
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String? baseUrl}) = _AuthRepository;
  @POST('/google')
  Future<LoginResponse> googleLogin({
    @Body() required GoogleLoginModel googleLoginModel,
  });

  @POST('/logout')
  @Headers({
    'accessToken': 'true',
  })
  Future<CommonResponse> logout();

  @DELETE('/sign-out')
  @Headers({
    'accessToken': 'true',
  })
  Future<CommonResponse> signOut();
}
