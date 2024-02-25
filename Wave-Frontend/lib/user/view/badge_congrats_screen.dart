import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';
import 'badge_screen.dart';

class BadgeCongratsScreen extends StatefulWidget {
  final String amount;
  final String count;

  static const String routeName = '/badge-congrats';

  const BadgeCongratsScreen({
    Key? key,
    required this.amount,
    required this.count,
  }) : super(key: key);

  @override
  _BadgeCongratsScreenState createState() => _BadgeCongratsScreenState();
}

class _BadgeCongratsScreenState extends State<BadgeCongratsScreen> {
  bool _showGif = true; // GIF를 표시할지 여부를 관리하는 변수
  late int amountIndex;
  late int countIndex;

  @override
  void initState() {
    super.initState();
    switch (widget.amount) {
      case "10":
        amountIndex = 1;
        break;
      case "100":
        amountIndex = 2;
        break;
      case "1000":
        amountIndex = 3;
        break;
      default:
        amountIndex = 0; // Default or error case
    }

    switch (widget.count) {
      case "1":
        countIndex = 1;
        break;
      case "5":
        countIndex = 2;
        break;
      case "10":
        countIndex = 3;
        break;
      case "50":
        countIndex = 4;
        break;
      case "100":
        countIndex = 5;
        break;
      default:
        countIndex = 0; // Default or error case
    }

    // 3초 후에 _showGif를 false로 설정하여 GIF를 숨깁니다.
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showGif = false;
      });
    });
  }

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
              if(widget.amount != "NONE" && widget.count != "NONE") // amount 뱃지를 획득했을 때 띄울 이미지
                Image.asset(
                  'assets/icons/badge/amountBadge${amountIndex}.png',
                width: 200,
                height: 200,
              ),

              if(widget.amount == "NONE" && widget.count != "NONE") // count 뱃지를 획득했을 때 띄울 이미지
                Image.asset(
                  'assets/icons/badge/countBadge${countIndex}.png',
                  width: 200,
                  height: 200,
                ),
              if(widget.amount != "NONE" && widget.count == "NONE") // count 뱃지를 획득했을 때 띄울 이미지
                Image.asset(
                  'assets/icons/badge/amountBadge${amountIndex}.png',
                  width: 200,
                  height: 200,
                ),
              const SizedBox(height: 24),
              const Text(
                "Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              if(widget.amount != "NONE" && widget.count != "NONE") // amount 뱃지를 획득했을 때 띄울 텍스트
              Text(
                "You've reached a donation of \$${widget.amount}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              if(widget.count != "NONE" && widget.amount == "NONE") // count 뱃지를 획득했을 때 띄울 텍스트
                Text(
                  "You've reached ${widget.count} donations",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              if(widget.count == "NONE" && widget.amount != "NONE") // count 뱃지를 획득했을 때 띄울 이미지
                Text(
                  "You've reached ${widget.amount} donations",
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
                  if(widget.amount != "NONE" && widget.count != "NONE")
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  BadgeCongratsScreen(count: widget.count, amount: "NONE")),
                  );

                  if(widget.count != "NONE" && widget.amount == "NONE") // count 뱃지를 획득했을 때 띄울 텍스트
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  BadgeScreen()),
                    );

                  if(widget.count == "NONE" && widget.amount != "NONE") // count 뱃지를 획득했을 때 띄울 텍스트
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  BadgeScreen()),
                    );
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
          if (_showGif)
            Positioned.fill(
              child: Image.asset(
                'assets/gif/light.gif',
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
