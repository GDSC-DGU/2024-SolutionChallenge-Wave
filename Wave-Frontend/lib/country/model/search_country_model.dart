import 'package:json_annotation/json_annotation.dart';

part 'search_country_model.g.dart';

@JsonSerializable()
class SearchCountryModel {
  final String category;
  final String mainTitle;
  final String subTitle;
  final String country;
  final String image;
  int views; // final을 제거하여 값을 변경할 수 있게
  final int id;

  SearchCountryModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.country,
    required this.image,
    required this.views,
    required this.id,
  });

  // JSON에서 SearchCountryModel 객체로 변환하는 팩토리 생성자
  factory SearchCountryModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCountryModelFromJson(json);

  // SearchCountryModel 객체를 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() => _$SearchCountryModelToJson(this);

  // views 값을 증가시키는 메소드(Optimistic UI를 위해 사용)
  void incrementViews() {
    views += 1;
  }

  // 객체의 값을 변경할 수 있는 copyWith 메소드
  SearchCountryModel copyWith({
    String? category,
    String? mainTitle,
    String? subTitle,
    String? country,
    String? image,
    int? views,
    int? id,
  }) {
    return SearchCountryModel(
      category: category ?? this.category,
      mainTitle: mainTitle ?? this.mainTitle,
      subTitle: subTitle ?? this.subTitle,
      country: country ?? this.country,
      image: image ?? this.image,
      views: views ?? this.views,
      id: id ?? this.id,
    );
  }
}
