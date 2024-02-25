// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountriesResponse _$DonateCountriesResponseFromJson(
        Map<String, dynamic> json) =>
    DonateCountriesResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonateCountriesDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$DonateCountriesResponseToJson(
        DonateCountriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
