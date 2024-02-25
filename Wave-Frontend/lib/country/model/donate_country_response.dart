import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import 'donate_country_model.dart';

part 'donate_country_response.g.dart';

@JsonSerializable()
class DonateCountryResponse extends CommonResponse {
  final DonateCountryModel? data;

  DonateCountryResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountryResponseToJson(this);
}

