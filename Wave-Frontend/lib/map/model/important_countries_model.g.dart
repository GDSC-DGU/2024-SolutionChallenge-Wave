// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'important_countries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportantCountriesModel _$ImportantCountriesModelFromJson(
        Map<String, dynamic> json) =>
    ImportantCountriesModel(
      emergency: (json['emergency'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      alert: (json['alert'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      caution: (json['caution'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      important:
          (json['important'] as List<dynamic>?)?.map((e) => e as int).toList(),
      donatePossibleList: (json['donatePossibleList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$ImportantCountriesModelToJson(
        ImportantCountriesModel instance) =>
    <String, dynamic>{
      'emergency': instance.emergency,
      'alert': instance.alert,
      'caution': instance.caution,
      'important': instance.important,
      'donatePossibleList': instance.donatePossibleList,
    };

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      id: json['id'] as int,
      isPossible: json['isPossible'] as bool,
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isPossible': instance.isPossible,
    };
