import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/map/component/country_painter.dart';
import 'package:wave/map/model/wave_select_country.dart';
import 'package:wave/payment/models/payment_request.dart';
import 'package:wave/user/component/show_confirmation_dialog.dart';
import 'package:wave/user/model/user_model.dart';
import 'package:wave/user/provider/user_me_provider.dart';
import 'package:wave/user/view/donate_completion_screen.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:ui' as ui;
import 'package:xml/xml.dart';
import 'package:wave/map/component/border_thumb_shape.dart';
import 'dart:developer' as dev;

/// Toss Payment 💵 => Toss Payments 를 사용해 앱내 결제를 할 수 있는 flutter 라이브러리
import 'package:toss_payment/feature/payments/webview/payment_webview.dart';
export 'package:toss_payment/extensions/uri_extension.dart';
export 'package:toss_payment/feature/payments/webview/payment_webview.dart';
import 'package:toss_payment/toss_payment.dart';

import '../../country/component/edit_amount_dialog.dart';
import '../../country/component/edit_donate_button.dart';

/// FF5039(빨강) 247EF4(파랑)
///
class WaveSelectScreen extends ConsumerStatefulWidget {
  static String get routeName => 'waveSelect';

  final String selectedCountry;
  final int id;

  WaveSelectScreen({
    Key? key,
    required this.selectedCountry,
    required this.id,
  }) : super(key: key);

  @override
  _WaveSelectScreenState createState() => _WaveSelectScreenState();
}

class _WaveSelectScreenState extends ConsumerState<WaveSelectScreen> {
  double _sliderValue = 0;
  List<WaveSelectCountryModel> _countries = [];

  @override
  void initState() {
    super.initState();
    _loadSvgImage('assets/images/${widget.selectedCountry.toLowerCase()}.svg');
  }

  double calculatePaymentAmount(double sliderValue) {
    return sliderValue * (1000 / _countries.length) * 1400;
  }

  void onPaymentButtonPressed(String name) {
    double amount = calculatePaymentAmount(_sliderValue); // 실제 결제 금액 계산
    PaymentRequest request = PaymentRequest.card(
        amount: amount.round(), // 계산된 금액을 반올림하여 정수로 변환
        orderId: "wre24a",
        orderName: name.toString(),
        customerName: '고객명');
    _showPayment(context, request); // 결제


    // PaymentRequest? ret;
    // ret = PaymentRequest.card(amount: 10000, orderId: "8ak23s", orderName: "도도", customerName: '저쟈');
    // _showPayment(context, ret);
  }

  Future<void> _loadSvgImage(String svgImage) async {
    final String svgContent = await rootBundle.loadString(svgImage);
    final document = XmlDocument.parse(svgContent);
    final paths = document.findAllElements('path');
    final localCountries = paths.map((node) {
      return WaveSelectCountryModel(
        id: node.getAttribute('id') ?? '',
        path: node.getAttribute('d') ?? '',
        color: node.getAttribute('fill')?.replaceAll('#', '') ?? 'FF5039',
      );
    }).toList();

    // Sort the countries list based on the numeric part of the id
    localCountries.sort((a, b) {
      int idA = int.parse(a.id.replaceAll(RegExp(r'[^0-9]'), ''));
      int idB = int.parse(b.id.replaceAll(RegExp(r'[^0-9]'), ''));
      return idA.compareTo(idB);
    });

    setState(() {
      _countries = localCountries;
    });
  }

  void _updateColors(double value) {
    int index = value.toInt();

    for (int i = 0; i <= index; i++) {
      _countries[i].color = '247EF4'; // 파란색
    }
    if (value == 0) {
      _countries[0].color = 'FF5039';
    }

    for (int i = index + 1; i < _countries.length; i++) {
      // 여기를 index에서 index + 1로 변경
      _countries[i].color = 'FF5039'; // 빨간색
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 금액을 문자열로 변환하는 함수
    String _formattedAmount(double value) {
      // Check if _countries is empty to avoid division by zero
      if (_countries.isEmpty) {
        return "\$0"; // Return $0 or any appropriate value when there are no countries
      }
      return "\$${(value * (1000 / _countries.length)).round().toStringAsFixed(0)}";
    }
// 선택된 금액을 저장할 변수

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

// 슬라이더의 값을 계산하고 업데이트하는 함수
    void _updateSliderAndAmount(double amount) {
      // 여기서는 예시로 amount를 최대 금액(예: 1000)으로 나누어 슬라이더의 최대값과 비교하는 방식을 사용합니다.
      // 실제 구현에서는 _countries.length와 다른 조건을 기반으로 계산할 수 있습니다.
      double sliderValue = (amount / 1000) * (_countries.isNotEmpty ? _countries.length : 1);

      setState(() {
        _sliderValue = sliderValue;
        _updateColors(sliderValue); // 슬라이더 값에 따라 국가 색상을 업데이트
      });
    }

    void _showEditAmountDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditAmountDialog(
            onAmountEdited: (double editedAmount) {
              _updateSliderAndAmount(editedAmount); // 사용자가 입력한 금액으로 슬라이더와 금액을 업데이트
            },
          );
        },
      );
    }

    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      isNeededCenterAppbar: true,
      title: 'Sending waves to ${widget.selectedCountry}',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 전체 컬럼을 화면 중앙으로
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 180),
            child: Center(
              child: Container(
                width: screenWidth,
                height: 1, // 여기에 원하는 높이 지정
                child: CustomPaint(
                  painter: CountryPainter(countries: _countries),
                ),
              ),
            ),
          ),
          _sliderValue == 0
              ? Text("Your waves can protect them!") // 0달러일 때 텍스트 표시
              : Text("You saved ${_sliderValue.toInt() + 1} region!"),
          SizedBox(height: 20), // 금액과 영어 텍스트 사이의 간격
          Center(
            child: Transform.translate(
              offset: Offset(14, 0), // 오른쪽으로 20px 이동
              child: Row(
                mainAxisSize: MainAxisSize.min, // Row의 크기를 자식들의 크기에 맞춤
                children: [
                  Text(
                    _formattedAmount(_sliderValue), // 여기서 _formattedAmount 함수는 슬라이더 값에 따른 문자열을 반환
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontWeight: FontWeight.w700,
                      fontSize: 33.5,
                    ),
                  ),
                  EditDonateButton(
                    onPressed: _showEditAmountDialog, // EditDonateButton 클릭 시 호출되는 함수
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10), // 슬라이더와 금액 사이의 간격
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 28.0,
              trackShape: RoundedRectSliderTrackShape(),
              activeTrackColor: PRIMARY_BLUE_COLOR,
              inactiveTrackColor: Colors.grey[100],
              thumbShape: CircleThumbShape(thumbRadius: 13),
              thumbColor: Colors.white,
              tickMarkShape: RoundSliderTickMarkShape(),
              inactiveTickMarkColor: Colors.white,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(), //
              valueIndicatorColor: Colors.white,
            ),
            child: Slider(
              min: 0,
              max: _countries.isNotEmpty
                  ? _countries.length.toDouble()
                  : 1.0,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  _updateColors(_sliderValue);
                });
              },
            ),
          ),
          SizedBox(height: 40), // 슬라이더와 버튼 사이의 간격
          ElevatedButton(
            onPressed: _sliderValue > 0
                ? () {
              final user = ref.read(userMeProvider) as UserModel;
              onPaymentButtonPressed(user.nickname); // 사용자 닉네임을 인자로 전달
            }
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (_sliderValue > 0) {
                    return PRIMARY_BLUE_COLOR; // 금액이 0이 아닐 때 버튼 색상
                  }
                  return Color(0xFFE2E2E8); // 금액이 0일 때 버튼 색상
                },
              ),
              fixedSize: MaterialStateProperty.all(Size(353, 62)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ), // _sliderValue가 0일 경우 버튼 비활성화
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200), // 텍스트 색상 변경 애니메이션 속도
              style: TextStyle(
                color: _sliderValue > 0 ? Colors.white : Colors.black.withOpacity(0.9),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              child: Text('Next'),
            ),
          ),
          SizedBox(height: 100), // 슬라이더와 버튼 사이의 간격
        ],
      ),
    );
  }

  _showPayment(BuildContext context, PaymentRequest request) async {

    int _formattedAmount(double value) {
      return ((value * (1000 / _countries.length)).round());
    }


    var ret = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          bool success = false;
          void popNow() {
            Navigator.of(context).pop();
            Navigator.of(context).pop(success);
          }
          return Container(
            margin: const EdgeInsets.only(top: 110),
            child: PaymentWebView(
              title: 'Wave Payment',
              paymentRequestUrl: request.url,
              onPageStarted: (url) {
                dev.log('onPageStarted.url = $url', name: "PaymentWebView");
              },
              onPageFinished: (url) {
                dev.log('onPageFinished.url = $url', name: "PaymentWebView");
                // TODO something to decide the payment is successful or not.
                success = url.contains('success');
                if(url.contains('/fail')){
                  Navigator.pop(context);
                }
                if (success) {
                  if (url.contains('amount=${request.amount}') &&
                      url.contains('orderId=${request.orderId}')) {
                    // ref.read(userMeProvider.notifier).postDonations(widget.id, _sliderValue.toInt() + 1);
                    ref.read(userMeProvider.notifier).postDonations(widget.id, _formattedAmount(_sliderValue));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonateCompletionScreen(
                          waves: _formattedAmount(_sliderValue),
                          country: widget
                              .selectedCountry, // selectedCountry 값을 country 파라미터로 전달
                        ),
                      ),
                    );
                  }
                }
              },
              onDisposed: () {
                print(request.url);
              },
              onTapCloseButton: ()  =>
                    showConfirmationDialog(
                      context,
                      'Do you want to cancel payment?',
                      'You will be returned to the wave select screen.',
                      popNow,
              ),
            ),
          );
        });
    dev.log('ret = $ret', name: '_showPayment');
  }
}

extension PaymentRequestExtension on PaymentRequest {
  Uri get url {

    return Uri.http("localhost:8080", "payment", json);
  }
}
