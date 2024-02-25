import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  final ErrorResponse? error;
  final bool success;

  CommonResponse({
    required this.success,
    this.error,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}

@JsonSerializable()
class ErrorResponse {
  final int code;
  final String message;

  ErrorResponse({
    required this.code,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}

