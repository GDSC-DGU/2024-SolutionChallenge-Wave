// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_badge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightBadgeModel _$LightBadgeModelFromJson(Map<String, dynamic> json) =>
    LightBadgeModel(
      amountBadge: json['amountBadge'] as String,
      countBadge: json['countBadge'] as String,
    );

Map<String, dynamic> _$LightBadgeModelToJson(LightBadgeModel instance) =>
    <String, dynamic>{
      'amountBadge': instance.amountBadge,
      'countBadge': instance.countBadge,
    };

LightBadgeResponse _$LightBadgeResponseFromJson(Map<String, dynamic> json) =>
    LightBadgeResponse(
      success: json['success'] as bool,
      data: LightBadgeModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$LightBadgeResponseToJson(LightBadgeResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };
