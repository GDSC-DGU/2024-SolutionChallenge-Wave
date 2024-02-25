// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_countries_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountriesData _$SearchCountriesDataFromJson(Map<String, dynamic> json) =>
    SearchCountriesData(
      emergency: (json['emergency'] as List<dynamic>?)
          ?.map((e) => SearchCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      alert: (json['alert'] as List<dynamic>?)
          ?.map((e) => SearchCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      caution: (json['caution'] as List<dynamic>?)
          ?.map((e) => SearchCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchCountriesDataToJson(
        SearchCountriesData instance) =>
    <String, dynamic>{
      'emergency': instance.emergency,
      'alert': instance.alert,
      'caution': instance.caution,
    };
