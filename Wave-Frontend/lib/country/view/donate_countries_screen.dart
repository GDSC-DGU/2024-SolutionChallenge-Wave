// // DUMMY DATA CODE (BEFORE API)
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wave/common/layout/default_layout.dart';
// import 'package:wave/country/component/donate_countries_card.dart';
// import 'package:wave/country/component/donate_country_label.dart';
// import 'package:wave/country/provider/donate_country_provider.dart';
// import 'package:wave/country/repository/donate_country_repository.dart';
// import 'package:wave/country/view/donate_country_detail_screen.dart';
//
// class DonateCountriesScreen extends ConsumerWidget {
//   static String get routeName => 'donateCountry';
//   const DonateCountriesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final donateCountries = ref.read(donateNotifierProvider.notifier).fetchDonateCountries();
//
//
//
//     return DefaultLayout(
//       isSingleChildScrollViewNeeded: true,
//       title: 'Sending Waves',
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const DonateCountryLabel(countryName: 'Ukraine'),
//             GestureDetector(
//               onTap: () {
//                 print('now?');
//                 context.goNamed(DonateCountryDetailScreen.routeName,
//                     pathParameters: {
//                       'id': '1',
//                     });
//                 ///   'id': model.id,
//               },
//               child: DonateCountryCard(
//                 category: 'Emergency',
//                 mainTitle: 'Help the People 🇺🇦',
//                 subTitle: 'of Ukraine affected by war',
//                 image: Image.asset(
//                   'assets/images/testImg.png',
//                   fit: BoxFit.cover,
//                 ),
//                 allWave: 6239,
//                 lastWave: 355,
//                 casualties: 490000, id: 5,
//               ),
//             ),
//             const DonateCountryLabel(countryName: 'Yemen'),
//             DonateCountryCard(
//               category: 'Emergency',
//               mainTitle: 'Help the People 🇾🇪',
//               subTitle: 'of Yemen affected by war',
//               image: Image.asset(
//                 'assets/images/testImg.png',
//                 fit: BoxFit.cover,
//               ),
//               allWave: 6239,
//               lastWave: 355,
//               casualties: 490000,
//               id: 5,
//             ),
//             const DonateCountryLabel(countryName: 'Syria'),
//             DonateCountryCard(
//               category: 'Emergency',
//               mainTitle: 'Help the People 🇸🇾',
//               subTitle: 'of Syria affected by war',
//               image: Image.asset(
//                 'assets/images/testImg.png',
//                 fit: BoxFit.cover,
//               ),
//               allWave: 6239,
//               lastWave: 355,
//               casualties: 490000,
//               id: 5,
//             ),
//             const DonateCountryLabel(countryName: 'Israel - Palestine'),
//             DonateCountryCard(
//               category: 'Emergency',
//               mainTitle: '🇵🇸Help the People 🇮🇱',
//               subTitle: 'of Israel - Palestine by war',
//               image: Image.asset(
//                 'assets/images/testImg.png',
//                 fit: BoxFit.cover,
//               ),
//               allWave: 6239,
//               lastWave: 355,
//               casualties: 490000,
//               id: 5,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// API TEST CODE

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/component/donate_country_label.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';

import '../model/donate_country_model.dart';

class DonateCountriesScreen extends ConsumerStatefulWidget {
  static String get routeName => 'donateCountry';

  const DonateCountriesScreen({super.key});

  @override
  ConsumerState<DonateCountriesScreen> createState() => _DonateCountriesScreenState();
}

class _DonateCountriesScreenState extends ConsumerState<DonateCountriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(donateNotifierProvider.notifier).fetchDonateCountries());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(donateNotifierProvider);

      if (state.isCountriesLoading || state.donateCountries == null) {
        return const LoadingScreen();
      } else {
        return DefaultLayout(
          isSingleChildScrollViewNeeded: true,
          title: 'Sending Waves',
          child: Padding(
            padding: const EdgeInsets.all(15), // 여기에 패딩을 추가합니다.
            child: Column(
              children: [
                _buildCountriesList(state.donateCountries!), // 기존에 구현한 리스트 빌더 함수
                SizedBox(height: 100), // 여기에 SizedBox를 추가하여 화면 하단에 공백을 추가합니다.
              ],
            ),
          ),
        );
      }
    });
  }

  Widget _buildCountriesList(List<DonateCountryModel> countries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: countries
          .map((country) => Column(
        children: [
          DonateCountryLabel(countryName: country.country),
          DonateCountryCard.fromModel(model: country, isDetail: false),
          const SizedBox(height: 30,)
        ],
      )).toList(),
    );
  }
}
