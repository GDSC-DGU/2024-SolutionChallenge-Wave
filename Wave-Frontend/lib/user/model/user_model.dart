import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final int id;
  final String nickname;
  final int totalWave;
  final int donationCountryCnt;
  final List<bool> countBadges;
  final List<bool> amountBadges;

  UserModel({
    required this.id,
    required this.nickname,
    required this.totalWave,
    required this.donationCountryCnt,
    required this.countBadges,
    required this.amountBadges,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}