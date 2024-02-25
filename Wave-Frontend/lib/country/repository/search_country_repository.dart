import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wave/common/const/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:wave/country/model/donate_country_detail_response.dart';
import 'package:wave/country/model/donate_country_response.dart';

import '../../common/dio/dio.dart';
import '../model/search_countries_response.dart';
import '../model/search_country_detail_response.dart';
import '../model/search_country_response.dart';

part 'search_country_repository.g.dart';

final searchCountryRepositoryProvider = Provider<SearchCountryRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = SearchCountryRepository(dio, baseUrl: '$ip/api/v1/countries');

  return repository;
});

@RestApi()
abstract class SearchCountryRepository {
  factory SearchCountryRepository(Dio dio, {String baseUrl}) = _SearchCountryRepository;

  @GET('/search')
  /// RESP 수정 필요
  Future<SearchCountriesResponse> getSearchCountries();

  // /api/v1/countries/search/{id}
  @GET('/search/{id}')
  Future<SearchCountryResponse> getSearchCountry({
    @Path() required int id,
  });

  // /api/v1/countries/search/{id}/detail
  @GET('/search/{id}/details')
  Future<SearchCountryDetailResponse> getSearchCountryDetail({
    @Path() required int id,
  });
}