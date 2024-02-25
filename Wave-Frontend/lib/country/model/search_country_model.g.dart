// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountryModel _$SearchCountryModelFromJson(Map<String, dynamic> json) =>
    SearchCountryModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      country: json['country'] as String,
      image: json['image'] as String,
      views: json['views'] as int,
      id: json['id'] as int,
    );

Map<String, dynamic> _$SearchCountryModelToJson(SearchCountryModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'country': instance.country,
      'image': instance.image,
      'views': instance.views,
      'id': instance.id,
    };
