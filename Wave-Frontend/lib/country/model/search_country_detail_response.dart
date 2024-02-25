import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/country/model/search_country_detail_model.dart';
import 'donate_country_detail_model.dart';

part 'search_country_detail_response.g.dart';

@JsonSerializable()
class SearchCountryDetailResponse extends CommonResponse {
  final SearchCountryDetailModel? data;

  SearchCountryDetailResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory SearchCountryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCountryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountryDetailResponseToJson(this);
}