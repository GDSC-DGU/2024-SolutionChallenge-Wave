import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/user/view/my_page_screen.dart';
import '../../map/view/global_map_screen.dart';

class DonateCompletionScreen extends StatelessWidget {
  final int waves;
  final String country;

  static const String routeName = '/donation-completion';

  DonateCompletionScreen({
    super.key,
    required this.waves,
    required this.country,
  });

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SvgPicture.asset(
              //   'assets/images/donationCompletionImage.svg',
              //   width: 150,
              //   height: 150,
              // ),
              Image.asset(
                'assets/images/donationCompletionImage.jpeg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                "You're a good donor!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "$waves waves were delivered to $country",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: ElevatedButton(
                onPressed: () {
                  context.pushReplacement('/donation-list');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_BLUE_COLOR,
                  minimumSize: const Size(353, 62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
