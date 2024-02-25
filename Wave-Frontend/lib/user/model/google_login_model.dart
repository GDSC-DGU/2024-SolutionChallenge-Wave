import 'package:json_annotation/json_annotation.dart';

part 'google_login_model.g.dart';

@JsonSerializable()
class GoogleLoginModel {
  final String id;
  final String displayName;

  GoogleLoginModel({
    required this.id,
    required this.displayName,
  });

  // JSON serialization methods
  factory GoogleLoginModel.fromJson(Map<String, dynamic> json) => _$GoogleLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleLoginModelToJson(this);
}
