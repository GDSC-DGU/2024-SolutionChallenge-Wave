import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'donate_countries_data_model.dart';

part 'donate_countries_response.g.dart';

@JsonSerializable()
class DonateCountriesResponse extends CommonResponse {
  final DonateCountriesDataModel? data; // 수정된 부분: List<DonateCountryModel>? 에서 CountriesData? 로 변경

  DonateCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateCountriesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DonateCountriesResponseToJson(this);
}
