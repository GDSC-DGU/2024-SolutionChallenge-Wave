import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/user/model/user_model.dart';

part 'user_info_response.g.dart';

@JsonSerializable()
class UserInfoResponse extends CommonResponse {
  final UserModel? data;

  UserInfoResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}


