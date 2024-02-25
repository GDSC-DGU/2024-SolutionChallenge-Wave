import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/country/component/modal_donate_countries_card.dart';
import 'package:wave/country/provider/donate_country_provider.dart';

import '../../common/const/colors.dart';

void showDonateCardModal(BuildContext context, int countryId, WidgetRef ref) async {
  // 데이터 로딩 시작
  await ref.read(donateNotifierProvider.notifier).fetchDonateCountry(countryId);

  // Ensure the context is still valid (the underlying widget is still mounted)
  // by checking if Navigator can find a context for it.
  if (!Navigator.of(context).mounted) return;

  // 데이터 로딩 완료 후 다이얼로그 표시
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.3),
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, _) {
          final donateNotifier = ref.watch(donateNotifierProvider);
          if (donateNotifier.donateCountry == null) {
            return const Center(child: CircularProgressIndicator(color: PRIMARY_BLUE_COLOR));
          } else {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 6, // 그림자 범위
                      blurRadius: 20, // 그림자 흐림 효과
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      child: ModalDonateCountryCard.fromModel(
                        model: donateNotifier.donateCountry!,
                        isDetail: false,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    },
  );
}