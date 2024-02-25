// important_countries_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/map/model/important_countries_model.dart';
import 'package:wave/map/repository/global_map_repository.dart';
import 'package:wave/map/model/important_countries_response.dart';

// autoDispose - 해당 프로바이더를 사용하는 위젯이 dispose될때 같이 dispose됨
// why? -> Map 탭은 항상 초기화 되어야함(다른 탭 이동하고 돌아와도 초기화 되어야함)

final importantCountriesProvider = StateNotifierProvider.autoDispose<ImportantCountriesNotifier, ImportantCountriesBase>(
      (ref) => ImportantCountriesNotifier(ref.read(globalMapRepositoryProvider)),
);


class ImportantCountriesNotifier extends StateNotifier<ImportantCountriesBase> {
  final GlobalMapRepository _repository;

  ImportantCountriesNotifier(this._repository) : super(ImportantCountriesLoading()) {

    _fetchImportantCountries();
  }

  Future<void> _fetchImportantCountries() async {
    print('kiki');
    try {
      final response = await _repository.getImportantCountries();
      print('why');
      if (response.success && response.data != null) {
        print('nuya');
        state = response.data!;
      } else {
        state = ImportantCountriesError(message: 'important countries data loading error in else in provider folder');
      }
    } catch (e) {
      state = ImportantCountriesError(message: 'important countries data loading error in catch provider folder');
    }
  }
}