import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import 'donate_country_detail_model.dart';

part 'donate_country_detail_response.g.dart';

@JsonSerializable()
class DonateCountryDetailResponse extends CommonResponse {
  final DonateCountryDetailModel? data;

  DonateCountryDetailResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountryDetailResponseToJson(this);
}