import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends CommonResponse {
  final Data? data;

  LoginResponse({
    required bool success,
    ErrorResponse? error,
    this.data,
  }) : super(success: success, error: error);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class Data {
  final String accessToken;
  final String refreshToken;

  Data({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
