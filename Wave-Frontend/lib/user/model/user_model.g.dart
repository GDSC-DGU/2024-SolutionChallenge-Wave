// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      totalWave: json['totalWave'] as int,
      donationCountryCnt: json['donationCountryCnt'] as int,
      countBadges:
          (json['countBadges'] as List<dynamic>).map((e) => e as bool).toList(),
      amountBadges: (json['amountBadges'] as List<dynamic>)
          .map((e) => e as bool)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'totalWave': instance.totalWave,
      'donationCountryCnt': instance.donationCountryCnt,
      'countBadges': instance.countBadges,
      'amountBadges': instance.amountBadges,
    };
