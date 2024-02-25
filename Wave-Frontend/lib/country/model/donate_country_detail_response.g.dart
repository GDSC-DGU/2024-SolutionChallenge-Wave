// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_country_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountryDetailResponse _$DonateCountryDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DonateCountryDetailResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonateCountryDetailModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$DonateCountryDetailResponseToJson(
        DonateCountryDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
