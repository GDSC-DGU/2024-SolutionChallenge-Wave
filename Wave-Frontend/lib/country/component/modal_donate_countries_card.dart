import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/donate_card_row.dart';
import 'package:wave/country/component/donate_button.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/model/donate_country_detail_model.dart';
import 'package:wave/country/view/donate_country_detail_screen.dart';
import 'package:wave/map/view/wave_select_screen.dart';
import '../model/donate_country_model.dart';

class ModalDonateCountryCard extends StatelessWidget {
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

  const ModalDonateCountryCard({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
    required this.id,
    required this.country,
    this.isDetail = false,
    this.heroKey,
    this.imageProducer,
    this.contents,
    this.detailImage,
    this.detailImageTitle,
    this.detailImageProducer,
    this.news,
    Key? key,
  }) : super(key: key);

  factory ModalDonateCountryCard.fromModel({
    required DonateCountryModel model,
    bool isDetail = false,
  }) {
    return ModalDonateCountryCard(
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      image: Image.network(
        model.image,
        fit: BoxFit.cover,
      ),
      allWave: model.allWave,
      lastWave: model.lastWave,
      casualties: model.casualties,
      country: model.country,
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
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              if (heroKey != null) // heroKey != null => detail이 아닌 경우(지도에서 클릭시랑 2번째 탭화면)
                Hero(
                  tag: ObjectKey(heroKey),
                  child: ClipRRect(
                    borderRadius:
                      const BorderRadius.only(
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
              Positioned(
                child: CategoryButton(category: category),
              ),
              Positioned(
                bottom: 8,
                left: 18,
                right: 8,
                child: Text(
                  "$mainTitle\n$subTitle",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
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
              ),
              child: ForwardDetailButton(
                buttonName: 'Sending Waves',
                onPressed: () {
                  print('kiki');
                  context.pushNamed(DonateCountryDetailScreen.routeName,
                      pathParameters: {
                        'id': id.toString(),
                      });
                },
                width: 240, // 너비를 240으로 지정
                height: 44, // 높이를 50으로 지정
                isSearch: true,
              ),
            ),
        ],
      ),
    );
  }
}
