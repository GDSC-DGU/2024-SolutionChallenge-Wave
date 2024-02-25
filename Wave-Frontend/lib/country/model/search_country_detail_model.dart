import 'package:json_annotation/json_annotation.dart';
import 'package:wave/country/model/search_country_model.dart';

part 'search_country_detail_model.g.dart';

@JsonSerializable()
class SearchCountryDetailModel extends SearchCountryModel {
  final String imageProducer;
  final List<Content> contents;
  final String detailImage;
  final String detailImageTitle;
  final String detailImageProducer;
  final List<News> news;

  SearchCountryDetailModel({
    required String category,
    required String mainTitle,
    required String subTitle,
    required String image,
    required int views,
    required int id,
    required String country,
    required this.imageProducer,
    required this.contents,
    required this.detailImage,
    required this.detailImageTitle,
    required this.detailImageProducer,
    required this.news,
  }) : super(
    category: category,
    mainTitle: mainTitle,
    subTitle: subTitle,
    image: image,
    views: views,
    id: id,
    country: country,
  );

  factory SearchCountryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCountryDetailModelFromJson(json);
}

@JsonSerializable()
class Content {
  final String title;
  final String content;

  Content({
    required this.title,
    required this.content,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}

@JsonSerializable()
class News {
  final String newsImage;
  final String newsTitle;
  final String newsUrl;
  final String date;

  News({
    required this.newsImage,
    required this.newsTitle,
    required this.newsUrl,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
