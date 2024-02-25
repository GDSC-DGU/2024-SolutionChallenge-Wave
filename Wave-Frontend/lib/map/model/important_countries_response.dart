import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import 'important_countries_model.dart';

part 'important_countries_response.g.dart';

@JsonSerializable()
class ImportantCountriesResponse extends CommonResponse {
  final ImportantCountriesModel? data;

  ImportantCountriesResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory ImportantCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$ImportantCountriesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImportantCountriesResponseToJson(this);
}

