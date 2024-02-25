// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationResponseModel _$DonationResponseModelFromJson(
        Map<String, dynamic> json) =>
    DonationResponseModel(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonationResponseData.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$DonationResponseModelToJson(
        DonationResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

DonationResponseData _$DonationResponseDataFromJson(
        Map<String, dynamic> json) =>
    DonationResponseData(
      totalWave: json['totalWave'] as int,
      donateList: (json['donateList'] as List<dynamic>)
          .map((e) => DonationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DonationResponseDataToJson(
        DonationResponseData instance) =>
    <String, dynamic>{
      'totalWave': instance.totalWave,
      'donateList': instance.donateList,
    };
