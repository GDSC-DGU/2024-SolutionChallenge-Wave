// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationModel _$DonationModelFromJson(Map<String, dynamic> json) =>
    DonationModel(
      date: json['date'] as String,
      country: json['country'] as String,
      time: json['time'] as String,
      id: json['id'] as int,
      wave: json['wave'] as int,
    );

Map<String, dynamic> _$DonationModelToJson(DonationModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'country': instance.country,
      'time': instance.time,
      'wave': instance.wave,
      'id': instance.id,
    };
