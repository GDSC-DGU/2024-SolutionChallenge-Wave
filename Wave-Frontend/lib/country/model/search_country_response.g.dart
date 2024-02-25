// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountryResponse _$SearchCountryResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCountryResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : SearchCountryModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$SearchCountryResponseToJson(
        SearchCountryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
