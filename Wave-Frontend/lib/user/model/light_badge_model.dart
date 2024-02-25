import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

part 'light_badge_model.g.dart';

@JsonSerializable()
class LightBadgeModel{
  final String amountBadge;
  final String countBadge;

  LightBadgeModel({
    required this.amountBadge,
    required this.countBadge,
  });

  factory LightBadgeModel.fromJson(Map<String, dynamic> json) => _$LightBadgeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LightBadgeModelToJson(this);

}

@JsonSerializable()
class LightBadgeResponse extends CommonResponse{
  final LightBadgeModel data;

  LightBadgeResponse({
    required bool success,
    required this.data,
    dynamic error,
  }): super(success: success, error: error);

  factory LightBadgeResponse.fromJson(Map<String, dynamic> json) => _$LightBadgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LightBadgeResponseToJson(this);
}