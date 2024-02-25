import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/country_category_button.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/component/translucence_category_button.dart';
import 'package:wave/country/model/search_country_detail_model.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import 'package:wave/country/view/search_country_detail_screen.dart';

import 'package:share/share.dart';

class SearchCountryCard extends ConsumerWidget {
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

  const SearchCountryCard({
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

  factory SearchCountryCard.fromModel({
    required SearchCountryModel model,
    bool isDetail = false,
  }) {
    return SearchCountryCard(
      country: model.country,
      id: model.id,
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      image: CachedNetworkImage(
        imageUrl: model.image,
        width: double.infinity,
        height: isDetail ? 300 : 145,
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
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isDetail == true
            ? BorderRadius.zero
            : const BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: isDetail == true
                ? Colors.transparent
                : Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
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
                        ? BorderRadius.zero
                        : const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: image,
                  ),
                ),
              if (heroKey == null)
                ClipRRect(
                  borderRadius: isDetail
                      ? BorderRadius.zero
                      : BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: image,
                ),
              if (heroKey !=
                  null && (isDetail == false)) // heroKey가 null => detail인 경우(컬러 카테고리 보여줄 필요 없음)
                Positioned(
                  child: CountryCategoryButton(
                    category: category,
                    countryName: country,
                  ),
                ),
              if (isDetail) // isDetail false => detail인 경우(컬러 카테고리 보여줄 필요 없음)
                Positioned(
                  bottom: 90, // 메인 타이틀과 서브타이틀의 높이를 고려하여 조정
                  left: 21,
                  child: TranslucenceCategoryButton(
                    text: category,
                  ),
                ),
              if (isDetail)
                Positioned(
                  bottom: 20,
                  left: 21,
                  right: 8,
                  child: Text(
                    "$mainTitle\n$subTitle",
                    style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.9)),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // isDetail이 false이거나 이미지 위에 겹쳐지지 않아야 하는 경우
                if (!isDetail)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          mainTitle,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(
                            'assets/icons/view.svg',
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        views.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                        ),
                      ),
                    ],
                  ),
                if (!isDetail)
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
              ],
            ),
          ),
          if (!isDetail)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: isDetail
                  ? SizedBox.shrink()
                  : ForwardDetailButton(
                buttonName: 'Learn their pain',
                onPressed: () {
                  context.pushNamed(
                    SearchCountryDetailScreen.routeName,
                    pathParameters: {'id': id.toString()},
                  );
                  // Optimistic Response (조회수 Up!)
                  // 0.5초 지연 후에 조회수 증가 로직 수행
                  Future.delayed(Duration(milliseconds: 500), () {
                    ref.read(searchNotifierProvider.notifier).incrementViews(id);
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
