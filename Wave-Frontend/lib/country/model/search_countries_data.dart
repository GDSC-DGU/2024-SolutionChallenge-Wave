import 'package:json_annotation/json_annotation.dart';
import 'search_country_model.dart';

part 'search_countries_data.g.dart';

@JsonSerializable()
class SearchCountriesData {
  final List<SearchCountryModel>? emergency;
  final List<SearchCountryModel>? alert;
  final List<SearchCountryModel>? caution;

  SearchCountriesData({this.emergency, this.alert, this.caution});

  factory SearchCountriesData.fromJson(Map<String, dynamic> json) =>
      _$SearchCountriesDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountriesDataToJson(this);
}
