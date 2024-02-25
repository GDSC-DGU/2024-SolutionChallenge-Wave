import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/model/search_country_detail_model.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:wave/country/view/search_country_detail_screen.dart';

import 'country_category_button.dart';

class ModalSearchCountryCard extends StatelessWidget {
  final String category;
  final String mainTitle;
  final String subTitle;
  final Widget image;
  final int views;
  final bool isDetail;
  final int? heroKey;
  final String? imageProducer;
  final List<Content>? contents;
  final String? detailImage;
  final String? detailImageTitle;
  final String? detailImageProducer;
  final List<News>? news;
  final int id;
  final String country;

  const ModalSearchCountryCard({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.views,
    this.isDetail = false,
    this.heroKey,
    this.imageProducer,
    this.contents,
    this.detailImage,
    this.detailImageTitle,
    this.detailImageProducer,
    this.news,
    required this.id,
    required this.country,
    Key? key,
  }) : super(key: key);

  factory ModalSearchCountryCard.fromModel({
    required SearchCountryModel model,
    bool isDetail = false,
  }) {
    return ModalSearchCountryCard(
      id: model.id,
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      image: Image.network(
        model.image,
        fit: BoxFit.cover,
      ),
      views: model.views,
      isDetail: isDetail,
      heroKey: model.id,
      imageProducer:
      model is SearchCountryDetailModel ? model.imageProducer : null,
      contents: model is SearchCountryDetailModel ? model.contents : null,
      detailImage: model is SearchCountryDetailModel ? model.detailImage : null,
      detailImageTitle:
      model is SearchCountryDetailModel ? model.detailImageTitle : null,
      detailImageProducer:
      model is SearchCountryDetailModel ? model.detailImageProducer : null,
      news: model is SearchCountryDetailModel ? model.news : null,
      country: model.country,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              if (heroKey != null)
                Hero(
                  tag: ObjectKey(heroKey),
                  child: ClipRRect(
                    borderRadius: isDetail
                        ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                        : const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: image,
                    ),
                  ),
                ),
              if (heroKey == null)
                ClipRRect(
                  borderRadius: isDetail
                      ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                      : BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Container(
                    height: 130,
                    width: 320,
                    child: image,
                  ),
                ),
                Positioned(
                  child: CategoryButton(
                    category: category,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mainTitle,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter, // 기본값이므로, 필요에 따라 조정할 수 있습니다.
                      child: Padding(
                        padding: EdgeInsets.only(top: 2), // SvgPicture.asset을 위로 조금 이동
                        child: SvgPicture.asset('assets/icons/view.svg', width: 10, height: 10),
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      views.toString(),
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF747474),
                      ), // View 카운트 글꼴 크기
                    ),
                  ],
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.9),
                  ), // 조절된 subTitle 글꼴 크기
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ForwardDetailButton(
              buttonName: 'Learn their pain',
              onPressed: () {
                context.pushNamed(SearchCountryDetailScreen.routeName,pathParameters: {
                  'id': id.toString(),
                });
              },
              width: 250,
              height: 45,
              isSearch: true,
            ),
          ),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
