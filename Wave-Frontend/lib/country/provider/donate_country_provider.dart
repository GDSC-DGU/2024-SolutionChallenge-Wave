import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/country/model/donate_countries_response.dart';
import 'package:wave/country/model/donate_country_detail_response.dart';
import 'package:wave/country/model/donate_country_response.dart';
import 'package:wave/country/repository/donate_country_repository.dart';
import '../model/donate_country_detail_model.dart';
import '../model/donate_country_model.dart';
import 'package:collection/collection.dart';


final donateNotifierProvider = ChangeNotifierProvider<DonateNotifier>((ref) {
  final repository = ref.watch(donateCountryRepositoryProvider);
  return DonateNotifier(repository);
});

class DonateNotifier extends ChangeNotifier {
  final DonateCountryRepository _repository;
  DonateCountryModel? donateCountry;
  DonateCountryDetailModel? donateCountryDetail;
  bool isCountryLoading = false; // 기존 국가 정보 로딩 상태
  bool isCountriesLoading = false; // 기존 국가 정보 로딩 상태
  bool isDetailLoading = false; // 상세 정보 로딩 상태 추가
  List<DonateCountryModel>? donateCountries;

  DonateNotifier(this._repository);

  // 기존 메서드는 유지하면서, 여러 국가 정보를 가져오는 메서드 추가
  Future<void> fetchDonateCountries() async {
    isCountriesLoading = true;
    notifyListeners();
    try {
      final response = await _repository.getDonateCountries();
      if (response.success && response.data != null) {
        donateCountries = response.data!.countries; // DonateCountriesDataModel에서 국가 목록 추출
      }
    } catch (error) {
      print('Error fetching countries: $error');
    } finally {

      notifyListeners();
      isCountriesLoading = false;
    }
  }

  Future<DonateCountryResponse?> fetchDonateCountry(int id) async {
    isCountryLoading = true;
    notifyListeners(); // 상태 변경 알림 시작
    try {
      final response = await _repository.getDonateCountry(id: id);
      if (response.success && response.data != null) {

        donateCountry = response.data!;

        isCountryLoading = false;

        notifyListeners(); // 상태 변경 알림 완료
        return response;
      }
    } catch (error) {
      print('Error fetching country: $error');
    } finally {
      isCountryLoading = false; // 여기서 상태 변경
      notifyListeners(); // 상태 변경 알림 완료
    }
    return null;
  }


  // 상세 국가 정보 로드
  Future<void> fetchDonateCountryDetail(int id) async {
    isDetailLoading = true;
    notifyListeners();
    try {
      final response = await _repository.getDonateCountryDetail(id: id);
      if (response.success && response.data != null) {
        // 상세 정보 업데이트
        donateCountryDetail = response.data!;
        if(donateCountry!=null){
          if(donateCountries?.firstWhereOrNull((country) => country.id == id) != null){
            donateCountry = donateCountries?.firstWhereOrNull((country) => country.id == id);
            print('gitup');
          }
          notifyListeners();
          return;
        }
        // 해당 국가의 기본 정보도 업데이트
        donateCountry = donateCountries?.firstWhereOrNull((country) => country.id == id);

      }
    } catch (error) {
      print('Error fetching country detail: $error');
    } finally {
      isDetailLoading = false;
      notifyListeners();
    }
  }

  Future<DonateCountriesResponse> getDonateCountries() async {
    try {
      return await _repository.getDonateCountries();
    } catch (error) {
      throw Exception('Failed to load countries');
    }
  }

}
