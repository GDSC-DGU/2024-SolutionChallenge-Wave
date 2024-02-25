import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/modal_search_countries_card.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import '../../common/const/colors.dart';

void showSearchCardModal(BuildContext context, int countryId, WidgetRef ref) async {
  // 데이터 로딩 시작
  await ref.read(searchNotifierProvider.notifier).fetchSearchCountry(countryId);

  // Ensure the context is still valid (the underlying widget is still mounted)
  if (!Navigator.of(context).mounted) return;

  // 데이터 로딩 완료 후 다이얼로그 표시
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.3), // 반투명한 흰색 배경
    builder: (BuildContext context) {
      // Provider를 통해 최신 상태를 구독
      return Consumer(
        builder: (context, ref, _) {
          final searchNotifier = ref.watch(searchNotifierProvider);
          // 데이터 로딩 여부 확인
          if (searchNotifier.state == SearchState.loaded) {
            return Dialog(
              backgroundColor: Colors.transparent, // Dialog의 배경을 투명하게 설정
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // 그림자 색상
                      spreadRadius: 6, // 그림자 범위
                      blurRadius: 20, // 그림자 흐림 효과
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 블러 효과 적용
                    child: Container(
                      color: Colors.white.withOpacity(0.8), // 실제 다이얼로그의 배경색 설정
                      child: ModalSearchCountryCard.fromModel(
                        model: searchNotifier.searchCountry!,
                        isDetail: false,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: PRIMARY_BLUE_COLOR));
          }
        },
      );
    },
  );
}

