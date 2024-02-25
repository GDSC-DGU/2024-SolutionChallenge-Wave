// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponse _$CommonResponseFromJson(Map<String, dynamic> json) =>
    CommonResponse(
      success: json['success'] as bool,
      error: json['error'] == null
          ? null
          : ErrorResponse.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommonResponseToJson(CommonResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
    };

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
