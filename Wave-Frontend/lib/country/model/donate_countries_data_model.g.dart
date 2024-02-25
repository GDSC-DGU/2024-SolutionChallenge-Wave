// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_countries_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountriesDataModel _$DonateCountriesDataModelFromJson(
        Map<String, dynamic> json) =>
    DonateCountriesDataModel(
      countries: (json['countries'] as List<dynamic>)
          .map((e) => DonateCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DonateCountriesDataModelToJson(
        DonateCountriesDataModel instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };
