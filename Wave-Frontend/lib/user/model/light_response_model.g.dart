// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightModel _$LightModelFromJson(Map<String, dynamic> json) => LightModel(
      isLightOn: json['isLightOn'] as bool,
    );

Map<String, dynamic> _$LightModelToJson(LightModel instance) =>
    <String, dynamic>{
      'isLightOn': instance.isLightOn,
    };

LightResponse _$LightResponseFromJson(Map<String, dynamic> json) =>
    LightResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : LightModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$LightResponseToJson(LightResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
