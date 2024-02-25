import 'package:json_annotation/json_annotation.dart';
import 'donate_country_model.dart';

part 'donate_countries_data_model.g.dart';

@JsonSerializable()
class DonateCountriesDataModel {
  final List<DonateCountryModel> countries;

  DonateCountriesDataModel({required this.countries});

  factory DonateCountriesDataModel.fromJson(Map<String, dynamic> json) => _$DonateCountriesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonateCountriesDataModelToJson(this);
}
