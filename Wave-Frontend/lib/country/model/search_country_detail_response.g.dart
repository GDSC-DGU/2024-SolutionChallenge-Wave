// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_country_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountryDetailResponse _$SearchCountryDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCountryDetailResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : SearchCountryDetailModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$SearchCountryDetailResponseToJson(
        SearchCountryDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
