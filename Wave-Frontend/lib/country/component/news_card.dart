import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave/country/component/translucence_category_button.dart';

class NewsCard extends StatelessWidget {
  final String newsImage;
  final String newsTitle;
  final String newsUrl;
  final String date;

  const NewsCard({
    Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsUrl,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(newsUrl))) {
          await launchUrl(Uri.parse(newsUrl));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $newsUrl'),
            ),
          );
        }
      },
      child: Container(
        width: 330,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(newsImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslucenceCategoryButton(
                    text: date,
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 290, // 제목 너비 제한
                    child: Text(
                      newsTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                        shadows: const [
                          Shadow(
                            color: Color(0xFF000000), // 그림자 색상
                            offset: Offset(3.0, 3.0), // 그림자 위치
                            blurRadius: 2.5, // 흐림 정도
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
