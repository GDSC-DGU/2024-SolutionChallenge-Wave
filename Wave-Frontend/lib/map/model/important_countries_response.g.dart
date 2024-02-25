// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'important_countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportantCountriesResponse _$ImportantCountriesResponseFromJson(
        Map<String, dynamic> json) =>
    ImportantCountriesResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : ImportantCountriesModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$ImportantCountriesResponseToJson(
        ImportantCountriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
