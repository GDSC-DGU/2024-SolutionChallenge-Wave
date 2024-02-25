// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_country_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountryDetailModel _$SearchCountryDetailModelFromJson(
        Map<String, dynamic> json) =>
    SearchCountryDetailModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      views: json['views'] as int,
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

Map<String, dynamic> _$SearchCountryDetailModelToJson(
        SearchCountryDetailModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'country': instance.country,
      'image': instance.image,
      'views': instance.views,
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
