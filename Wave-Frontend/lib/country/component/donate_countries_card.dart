import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/donate_card_row.dart';
import 'package:wave/country/component/donate_button.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/component/small_button.dart';
import 'package:wave/country/component/translucence_category_button.dart';
import 'package:wave/country/model/donate_country_detail_model.dart';
import 'package:wave/country/view/donate_country_detail_screen.dart';
import 'package:wave/map/view/wave_select_screen.dart';
import '../../discription/view/discription_screen.dart';
import '../model/donate_country_model.dart';

class DonateCountryCard extends StatelessWidget {
  final String category;
  final String mainTitle;
  final String subTitle;
  final Widget image;
  final int allWave;
  final int lastWave;
  final int casualties;
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

  const DonateCountryCard({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
    required this.id,
    this.isDetail = false,
    this.heroKey,
    this.imageProducer,
    this.contents,
    this.detailImage,
    this.detailImageTitle,
    this.detailImageProducer,
    this.news,
    required this.country,
    Key? key,
  }) : super(key: key);

  factory DonateCountryCard.fromModel({
    required DonateCountryModel model,
    bool isDetail = false,
  }) {
    return DonateCountryCard(
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      image: CachedNetworkImage(
        imageUrl: model.image,
        width: double.infinity,
        height: isDetail ? 300 : 180,
        fit: BoxFit.cover,
      ),
      allWave: model.allWave,
      lastWave: model.lastWave,
      casualties: model.casualties,
      isDetail: isDetail,
      heroKey: model.id,
      imageProducer:
          model is DonateCountryDetailModel ? model.imageProducer : null,
      contents: model is DonateCountryDetailModel ? model.contents : null,
      detailImage: model is DonateCountryDetailModel ? model.detailImage : null,
      detailImageTitle:
          model is DonateCountryDetailModel ? model.detailImageTitle : null,
      detailImageProducer:
          model is DonateCountryDetailModel ? model.detailImageProducer : null,
      news: model is DonateCountryDetailModel ? model.news : null,
      id: model.id,
      country: model.country,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            offset: Offset(0, 3),
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
                        ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                        : const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                    child: Container(child: image),
                  ),
                ),
              if (!isDetail) // isDetail false => detail인 경우(컬러 카테고리 보여줄 필요 없음)
                Positioned(
                  child: CategoryButton(category: category),
                ),
              if (isDetail) // isDetail false => detail인 경우(컬러 카테고리 보여줄 필요 없음)
                Positioned(
                  bottom: 90, // 메인 타이틀과 서브타이틀의 높이를 고려하여 조정
                  left: 21,
                  child: TranslucenceCategoryButton(
                    text: category,
                  ),
                ),
              Positioned(
                bottom: 20,
                left: 21,
                right: 8,
                child: Text(
                  "$mainTitle\n$subTitle",
                  style: TextStyle(
                      fontSize: isDetail ? 21.0 : 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.9)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DonateCardRow(
              allWave: allWave,
              lastWave: lastWave,
              casualties: casualties,
            ),
          ),
          if (!isDetail)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 26.0,
                vertical: 5,
              ),
              child: ForwardDetailButton(
                buttonName: 'Sending Waves',
                onPressed: () {
                  context.pushNamed(DonateCountryDetailScreen.routeName,
                      pathParameters: {
                        'id': id.toString(),
                      });
                },
              ),
            ),
          if (!isDetail)
            SizedBox(height: 18,),
          if (isDetail)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  child: Container(
                    //width: 60, // 너비 60
                    height: 60, // 높이 60
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // 모서리 둥글게 처리
                    ),
                    // child: InkWell(
                    //   onTap: () async{
                    //     // final String shareContent = 'Check out this interesting place: $mainTitle\n$country';
                    //     // Share.share(shareContent);
                    //     print('here');
                    //     await Share.share('Wave', subject: 'Check out this interesting place: $mainTitle\n$country');
                    //   },
                    //   child: SvgPicture.asset(
                    //     'assets/icons/share.svg', // SVG 이미지 경로
                    //     width: 60, // SVG 이미지 너비 설정
                    //     height: 60, // SVG 이미지 높이 설정
                    //     fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정
                    //   ),
                    // ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Row 전체에 패딩 적용
                    child: Row(
                      children: [
                        SmallButton(
                          svgPath: 'assets/images/discriptionButton.svg', // SVG 파일 경로
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DiscriptionScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 16), // SmallButton과 DonateButton 사이의 간격
                        Expanded(
                          child: DonateButton(
                            buttonName: 'Donate',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WaveSelectScreen(
                                    selectedCountry: country,
                                    id: id,
                                  ),
                                ),
                              );
                            },
                            height: 60.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          if (isDetail)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: BUTTON_BACKGROUND_COLOR,
                thickness: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}
