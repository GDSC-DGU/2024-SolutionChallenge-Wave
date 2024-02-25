import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wave/map/model/important_countries_response.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'global_map_repository.g.dart';

final globalMapRepositoryProvider = Provider<GlobalMapRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return GlobalMapRepository(dio, baseUrl: '$ip/api/v1');
  },
);

@RestApi()
abstract class GlobalMapRepository {
  factory GlobalMapRepository(Dio dio, {String baseUrl}) = _GlobalMapRepository;

  @GET('/countries')
  Future<ImportantCountriesResponse> getImportantCountries();
}
