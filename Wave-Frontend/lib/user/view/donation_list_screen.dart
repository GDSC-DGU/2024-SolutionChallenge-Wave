import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/user/model/donation_model.dart';
import 'package:wave/user/repository/user_me_repository.dart';
import '../../common/layout/default_layout.dart';
import '../../loading/loading_screen.dart';
import '../component/donation_list_donated_summary.dart';
import '../component/donation_list_tile.dart';
import '../model/donation_response_model.dart';

class DonationListScreen extends ConsumerStatefulWidget {
  const DonationListScreen({Key? key}) : super(key: key);

  static const String routeName = '/donation-list';

  @override
  ConsumerState<DonationListScreen> createState() => _DonationListScreenState();
}

class _DonationListScreenState extends ConsumerState<DonationListScreen> {
  @override
  Widget build(BuildContext context) {
    final donationListAsyncValue = ref.watch(donationListProvider);
    return DefaultLayout(
      isNeededCenterAppbar: true,
      title: 'Donation list',
      child: donationListAsyncValue.when(
        data: (data) => _buildDonationListUI(data.data?.donateList ?? [], data.data?.totalWave ?? 0),
        loading: () => const LoadingScreen(),
        error: (e, stack) => Center(child: Text('An error occurred: $e')),
      ),
    );
  }
}

Widget _buildDonationListUI(List<DonationModel> donations, int totalWave) {
  return Column(
    children: [
      // 전체 기부 파도 요약 정보를 표시하는 위젯
      DonatedWavesSummary(totalWave: totalWave),
      const SizedBox(height: 16),
      // 구분선
      SizedBox(
        height: 12,
        child: Container(
          color: const Color(0xFFF1F1F7),
        ),
      ),
      const SizedBox(height: 40),
      // 기부 목록이 있는 경우 목록을 표시
      donations.isNotEmpty
          ? Expanded(
        child: ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            // 각 기부 항목에 대한 타일 생성
            final donation = donations[index];
            return DonationListTile(donation: donation);
          },
        ),
      )
          : Expanded(
        // 기부 목록이 비어있는 경우 메시지 표시
        child: Center(
          child: Text(
            'There is no history of donation.\nPlease give rise to 🌊Wave🌊\nthat will make a difference in the world!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}
final donationListProvider = FutureProvider.autoDispose<DonationResponseModel>((ref) async {
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  return userMeRepository.getDonations();
});
