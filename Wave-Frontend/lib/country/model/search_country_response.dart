import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/country/model/search_country_model.dart';

part 'search_country_response.g.dart';

@JsonSerializable()
class SearchCountryResponse extends CommonResponse {
  final SearchCountryModel? data;

  SearchCountryResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory SearchCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountryResponseToJson(this);
}