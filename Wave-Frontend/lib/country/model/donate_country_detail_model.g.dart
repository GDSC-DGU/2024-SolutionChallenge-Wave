// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_country_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountryDetailModel _$DonateCountryDetailModelFromJson(
        Map<String, dynamic> json) =>
    DonateCountryDetailModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      allWave: json['allWave'] as int,
      lastWave: json['lastWave'] as int,
      casualties: json['casualties'] as int,
      id: json['id'] as int,
      country: json['country'] as String,
      imageProducer: json['imageProducer'] as String,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      detailImage: json['detailImage'] as String,
      detailImageTitle: json['detailImageTitle'] as String,
      detailImageProducer: json['detailImageProducer'] as String,
      news: (json['news'] as List<dynamic>)
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DonateCountryDetailModelToJson(
        DonateCountryDetailModel instance) =>
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
      'imageProducer': instance.imageProducer,
      'contents': instance.contents,
      'detailImage': instance.detailImage,
      'detailImageTitle': instance.detailImageTitle,
      'detailImageProducer': instance.detailImageProducer,
      'news': instance.news,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

News _$NewsFromJson(Map<String, dynamic> json) => News(
      newsImage: json['newsImage'] as String,
      newsTitle: json['newsTitle'] as String,
      newsUrl: json['newsUrl'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'newsImage': instance.newsImage,
      'newsTitle': instance.newsTitle,
      'newsUrl': instance.newsUrl,
      'date': instance.date,
    };
