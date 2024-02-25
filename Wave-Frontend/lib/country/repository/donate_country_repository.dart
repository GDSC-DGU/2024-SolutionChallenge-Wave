import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wave/common/const/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:wave/country/model/donate_countries_response.dart';
import 'package:wave/country/model/donate_country_detail_response.dart';
import 'package:wave/country/model/donate_country_response.dart';

import '../../common/dio/dio.dart';

part 'donate_country_repository.g.dart';

final donateCountryRepositoryProvider = Provider<DonateCountryRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = DonateCountryRepository(dio, baseUrl: '$ip/api/v1/countries');

  return repository;
});

@RestApi()
abstract class DonateCountryRepository {
  factory DonateCountryRepository(Dio dio, {String baseUrl}) = _DonateCountryRepository;

  /// 1. 기부 가능 국가 목록 조회
  ///
  @GET('/donate')
  /// RESP 수정 필요
  Future<DonateCountriesResponse> getDonateCountries();


  /// 2. 기부 가능 국가 id 조회
  // /api/v1/countries/donate/{id}
  @GET('/donate/{id}')
  Future<DonateCountryResponse> getDonateCountry({
    @Path() required int id,
});

  /// 3. 기부 가능 국가 id 상세 조회
  // /api/v1/countries/donate/{id}/detail
  @GET('/donate/{id}/details')
  Future<DonateCountryDetailResponse> getDonateCountryDetail({
    @Path() required int id,
  });
}