import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

part 'light_response_model.g.dart';

@JsonSerializable()
class LightModel{
 final bool isLightOn;

  LightModel({
    required this.isLightOn,
  });

  factory LightModel.fromJson(Map<String, dynamic> json) =>
      _$LightModelFromJson(json);
}

@JsonSerializable()
class LightResponse extends CommonResponse{
  final LightModel? data;

  LightResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory LightResponse.fromJson(Map<String, dynamic> json) =>
      _$LightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LightResponseToJson(this);
}