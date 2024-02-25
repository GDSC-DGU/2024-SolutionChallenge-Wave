// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountryModel _$DonateCountryModelFromJson(Map<String, dynamic> json) =>
    DonateCountryModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      allWave: json['allWave'] as int,
      lastWave: json['lastWave'] as int,
      casualties: json['casualties'] as int,
      id: json['id'] as int,
      country: json['country'] as String,
    );

Map<String, dynamic> _$DonateCountryModelToJson(DonateCountryModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'allWave': instance.allWave,
      'lastWave': instance.lastWave,
      'casualties': instance.casualties,
      'country': instance.country,
      'id': instance.id,
    };
