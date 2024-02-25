import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/country/model/search_countries_data.dart';
import 'package:wave/country/repository/search_country_repository.dart';
import 'package:wave/country/model/search_countries_response.dart';
import 'package:wave/country/model/search_country_response.dart';
import 'package:wave/country/model/search_country_detail_model.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:collection/collection.dart';

enum SearchState { idle, loading, loaded, error }

final searchNotifierProvider = ChangeNotifierProvider(
        (ref) => SearchNotifier(ref.watch(searchCountryRepositoryProvider)));

class SearchNotifier extends ChangeNotifier {
  final SearchCountryRepository _repository;
  SearchCountryModel? searchCountry;
  SearchCountryDetailModel? searchCountryDetail;
  SearchCountriesData? searchCountriesData;
  SearchState state = SearchState.idle;
  String? errorMessage;

  SearchNotifier(this._repository) {
    print('debugrightnow1');
    Future.microtask(() => fetchSearchCountries());
  }


  List<SearchCountryModel> getEmergencyCountries() {
    return searchCountriesData?.emergency ?? [];
  }

  List<SearchCountryModel> getAlertCountries() {
    return searchCountriesData?.alert ?? [];
  }

  List<SearchCountryModel> getCautionCountries() {
    return searchCountriesData?.caution ?? [];
  }

  void _setState(SearchState state) {
    if (this.state != state) {
      this.state = state;
      notifyListeners();
    }
  }

  void setError(String message) {
    errorMessage = message;
    _setState(SearchState.error);
  }

  Future<void> fetchSearchCountries() async {
    _setState(SearchState.loading);
    print('debugrightnow2');
    try {
      final response = await _repository.getSearchCountries();
      if (response.success && response.data != null) {
        print('SearchState.loaded: ${state.index}');
        searchCountriesData = response.data;
        _setState(SearchState.loaded);
        print('searchCountriesData: $searchCountriesData');
        print('SearchState.loaded1: ${state.index}');
      } else {
        setError("Failed to load search countries data.");
      }
    } catch (error) {
      setError("Error fetching search countries: $error");
    }
  }

  Future<void> fetchSearchCountry(int id) async {
    _setState(SearchState.loading);
    try {
      final response = await _repository.getSearchCountry(id: id);
      if (response.success && response.data != null) {
        searchCountry = response.data;
        _setState(SearchState.loaded);
        print('SearchState.loaded2: ${state.index}');
      } else {
        setError("Failed to load search country data.");
      }
    } catch (error) {
      setError("Error fetching search country: $error");
    }
  }

  // SearchNotifier 클래스 내부에 메소드 추가
  void incrementViews(int id) {
    // ID에 해당국가의 조회수를 찾아서 1 증가
    print('id:${id}');
    final country = searchCountriesData?.emergency?.firstWhereOrNull((c) => c.id == id) ??
        searchCountriesData?.alert?.firstWhereOrNull((c) => c.id == id) ??
        searchCountriesData?.caution?.firstWhereOrNull((c) => c.id == id);

    print('country: $country');

    if (country != null) {
      country.incrementViews();
      notifyListeners();
    }
  }


  Future<void> fetchSearchCountryDetail(int id) async {
    print('debugrightnow3');
    updateState(SearchState.loading);
    try {
      final response = await _repository.getSearchCountryDetail(id: id);
      if (response.success && response.data != null) {
        searchCountryDetail = response.data!;
        updateSearchCountry(id);
        updateState(SearchState.loaded);
        print('you finished it');
      } else {
        setError("Failed to load search country detail.");
      }
    } catch (error) {
      setError("Error fetching search country detail: $error");
    }
  }

  void updateSearchCountry(int id) {
    final List<SearchCountryModel> allCountries = [
      ...searchCountriesData?.emergency ?? [],
      ...searchCountriesData?.alert ?? [],
      ...searchCountriesData?.caution ?? [],
    ];

    searchCountry = allCountries.firstWhereOrNull((country) => country.id == id);
    if (searchCountry != null) {
      print('Country found and updated.');
      notifyListeners();
    }
  }


  void updateState(SearchState newState) {
    if (state != newState) {
      state = newState;
    }
  }
}