import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wave/user/model/light_badge_model.dart';
import 'package:wave/user/model/light_response_model.dart';
import 'package:wave/user/model/send_wave_model.dart';
import 'package:wave/user/model/user_info_response.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/donation_response_model.dart';
import '../model/user_model.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: '$ip/api/v1/users');
  },
);

// http://$ip/user/me
@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserInfoResponse> getMe(); // token authentication 용 test api

  @POST('/donate')
  @Headers({
    'accessToken': 'true',
  })
  Future<DonationResponseModel> postDonations(@Body() SendWaveModel sendWaveModel);


  @GET('/donate')
  @Headers({
    'accessToken': 'true',
  })
  Future<DonationResponseModel> getDonations();

  @GET('/light')
  @Headers({
    'accessToken': 'true',
  })
  Future<LightResponse> getLight();

  @GET('/new-badge')
  @Headers({
    'accessToken': 'true',
  })
  Future<LightBadgeResponse> getNewBadge();

}
