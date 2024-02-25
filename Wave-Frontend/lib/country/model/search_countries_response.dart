import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'search_countries_data.dart';

part 'search_countries_response.g.dart';

@JsonSerializable()
class SearchCountriesResponse extends CommonResponse {
  final SearchCountriesData? data; // SearchCountriesData 타입으로 변경됨

  SearchCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory SearchCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCountriesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchCountriesResponseToJson(this);
}
