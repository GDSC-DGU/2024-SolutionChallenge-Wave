

import 'package:json_annotation/json_annotation.dart';

part 'important_countries_model.g.dart';

// 상태 정의
abstract class ImportantCountriesBase {}

class ImportantCountriesError extends ImportantCountriesBase {
  final String message;
  ImportantCountriesError({required this.message});
}

class ImportantCountriesLoading extends ImportantCountriesBase {}


@JsonSerializable()
class ImportantCountriesModel extends ImportantCountriesBase {
  final List<CountryData>? emergency;
  final List<CountryData>? alert;
  final List<CountryData>? caution;
  final List<int>? important;
  final List<int>? donatePossibleList;

  ImportantCountriesModel({
    this.emergency,
    this.alert,
    this.caution,
    this.important,
    this.donatePossibleList,
  });

  factory ImportantCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$ImportantCountriesModelFromJson(json);
}

@JsonSerializable()
class CountryData {
  final int id;
  final bool isPossible;

  CountryData({
    required this.id,
    required this.isPossible,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);
}
