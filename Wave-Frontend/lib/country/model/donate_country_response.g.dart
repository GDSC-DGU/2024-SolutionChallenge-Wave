// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountryResponse _$DonateCountryResponseFromJson(
        Map<String, dynamic> json) =>
    DonateCountryResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonateCountryModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$DonateCountryResponseToJson(
        DonateCountryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
