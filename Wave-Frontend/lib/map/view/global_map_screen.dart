import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/modal_donate_countries_card.dart';
import 'package:wave/country/component/modal_search_countries_card.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';
import 'package:wave/map/component/blue_grid_pattern.dart';
import 'package:wave/map/component/current_zoom_level.dart';
import 'package:wave/map/component/risk_level_button.dart';
import 'package:wave/map/component/show_donate_card_modal.dart';
import 'package:wave/map/component/show_search_card_modal.dart';
import 'package:wave/map/model/important_countries_model.dart';
import 'package:wave/map/model/marker_model.dart';
import '../provider/global_map_provider.dart';

class GlobalMapScreen extends ConsumerStatefulWidget {
  @override
  _GlobalMapScreenState createState() => _GlobalMapScreenState();
}

class _GlobalMapScreenState extends ConsumerState<GlobalMapScreen> {
  MapShapeSource? _dataSource;
  MapZoomPanBehavior? _zoomPanBehavior;
  bool _isLoading = true;
  double currentZoomLevel = 3;

  // api call로 받아온 데이터를 저장할 위험 국가 리스트 ID
  List<int> lowRiskCountriesId = [];
  List<int> midRiskCountriesId = [];
  List<int> highRiskCountriesId = [];
  List<int> importantCountriesId = [];
  List<int> donatePossibleCountriesId = [];

  // 변경: 리스크 레벨별 상태 관리
  bool _showLowRisk = false;
  bool _showMidRisk = false;
  bool _showHighRisk = false;

  List features = [];
  late List<MarkerModel> _data;
  @override
  void initState() {
    _isLoading = true;
    _zoomPanBehavior = MapZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePanning: true,
      zoomLevel: currentZoomLevel,
      minZoomLevel: 2,
      maxZoomLevel: 11,
      latLngBounds: const MapLatLngBounds(
        MapLatLng(71.538800, 179.148909), // 북동 경계
        MapLatLng(-55.973798, -179.148909), // 남서 경계
      ),
    );
    super.initState();
    _showHighRisk = !_showHighRisk;
    _showMidRisk = !_showMidRisk;
    _showLowRisk = !_showLowRisk;
    _data = const <MarkerModel>[
      MarkerModel('Yemen', 13.5527, 45.5164, 173),
      MarkerModel('Ukraine', 51.1794, 31.1656, 166),
      MarkerModel('Syria', 36.0021, 40.2968, 153),
      MarkerModel('Palestine', 29.9522, 35.2332, 132),
    ];
    _updateDataSource();
  }

  Future<void> _updateDataSource() async {
    final jsonString =
        await rootBundle.loadString('assets/maps/world_map.json');
    final jsonResponse = json.decode(jsonString);
    features = jsonResponse['features'] as List;
    setState(() {
      _dataSource = MapShapeSource.asset(
        'assets/maps/world_map.json',
        shapeDataField: 'name',
        dataCount: features.length,
        primaryValueMapper: (int index) =>
            features[index]['properties']['name'],
        shapeColorValueMapper: (int index) =>
            _getRiskLevelColor(features[index]['properties']['id']),
        dataLabelMapper: (int index) =>
            jsonResponse['features'][index]['properties']['name'],
      );
    });
  }

  void _panMap() {
    if (_zoomPanBehavior != null && _zoomPanBehavior!.focalLatLng != null) {
      final currentFocalPoint = _zoomPanBehavior!.focalLatLng!;
      final newFocalPoint = MapLatLng(
          currentFocalPoint.latitude, currentFocalPoint.longitude + 0.00000001);
      _zoomPanBehavior!.focalLatLng = newFocalPoint;
    }
  }

  Color _getRiskLevelColor(int countryId) {
    if (lowRiskCountriesId.contains(countryId) && _showLowRisk) {
      return CAUTION_YELLO_COLOR;
    } else if (midRiskCountriesId.contains(countryId) && _showMidRisk) {
      return ALERT_ORANGE_COLOR;
    } else if (highRiskCountriesId.contains(countryId) && _showHighRisk) {
      return EMERGENCY_RED_COLOR;
    } else {
      return PRIMARY_GRAY_COLOR;
    }
  }

  void _updateRiskCountriesLists(ImportantCountriesModel data) {
    // emergency, alert, caution 리스트를 업데이트하는 로직 구현
    lowRiskCountriesId = data.caution?.map((e) => e.id).toList() ?? [];
    midRiskCountriesId = data.alert?.map((e) => e.id).toList() ?? [];
    highRiskCountriesId = data.emergency?.map((e) => e.id).toList() ?? [];
    importantCountriesId = data.important ?? [];
    donatePossibleCountriesId = data.donatePossibleList ?? [];
  }

  final maxHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importantCountriesProvider);
    // 데이터 로딩 상태에 따른 UI 렌더링
    if (state is ImportantCountriesLoading || _dataSource == null) {
      return const LoadingScreen();
    } else if (state is ImportantCountriesError) {
      return DefaultLayout(
        child: Center(child: Text('⭐️ Error ⭐️: ${state.message}')),
      );
    } else if (state is ImportantCountriesModel) {
      if (_isLoading || _dataSource == null) {
        _updateRiskCountriesLists(state);
        _isLoading = false;
      }
    }
    return DefaultLayout(
      title: 'World Conflict Map',
      child: Container(
        height: maxHeight * 0.9,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlueGridPattern(zoomLevel: currentZoomLevel),
            ),
            SfMaps(
              layers: [
                MapShapeLayer(
                  onSelectionChanged: (int index) {
                    setState(() {
                      final int countryId = features[index]['properties']['id'];
                      final bool isLowRisk =
                          lowRiskCountriesId.contains(countryId);
                      final bool isMidRisk =
                          midRiskCountriesId.contains(countryId);
                      final bool isHighRisk =
                          highRiskCountriesId.contains(countryId);

                      if ((isLowRisk && !_showLowRisk) ||
                          (isMidRisk && !_showMidRisk) ||
                          (isHighRisk && !_showHighRisk)) {
                        return;
                      }

                      if (donatePossibleCountriesId.contains(countryId)) {
                        showDonateCardModal(context, countryId, ref);
                      } else if (importantCountriesId.contains(countryId)) {
                        showSearchCardModal(context, countryId, ref);
                      }
                    });
                  },
                  initialMarkersCount: 4,
                  markerBuilder: (BuildContext context, int index) {
                    final MarkerModel model = _data[index];
                    return MapMarker(
                      latitude: model.latitude,
                      longitude: model.longitude,
                      child: GestureDetector(
                        onTap: () {
                          final countryId = model.id;
                          if (donatePossibleCountriesId.contains(countryId)) {
                            showDonateCardModal(context, countryId, ref);
                          } else if (importantCountriesId.contains(countryId)) {
                            showSearchCardModal(context, countryId, ref);
                          }
                        },
                        child: SvgPicture.asset(
                          'assets/icons/test.svg',
                          height: 13,
                          width: 13,
                        ),
                      ),
                    );
                  },
                  onWillPan: (MapPanDetails details) {
                    return true;
                  },
                  source: _dataSource!,
                  zoomPanBehavior: _zoomPanBehavior,
                  showDataLabels: true,
                  dataLabelSettings: getDataLabelSettings(currentZoomLevel),
                  onWillZoom: (MapZoomDetails details) {
                    if (details.newZoomLevel != null) {
                      setState(() {
                        currentZoomLevel = details.newZoomLevel!;
                      });
                    }
                    return true;
                  },
                  selectionSettings: MapSelectionSettings(
                    color: Colors.indigo,
                    strokeColor: Colors.indigo,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 10,
              child: Row(
                children: [
                  RiskLevelButton(
                    riskLevel: 'Emergency',
                    isSelected: _showHighRisk,
                    color: PRIMARY_BLUE_COLOR,
                    onPressed: () {
                      setState(() {
                        _showHighRisk = !_showHighRisk;
                        _updateDataSource();
                        _panMap();
                      });
                    },
                  ),
                  RiskLevelButton(
                    riskLevel: 'Alert',
                    isSelected: _showMidRisk,
                    color: PRIMARY_BLUE_COLOR,
                    onPressed: () {
                      setState(() {
                        _showMidRisk = !_showMidRisk;
                        _updateDataSource();
                        _panMap();
                      });
                    },
                  ),
                  RiskLevelButton(
                    riskLevel: 'Caution',
                    isSelected: _showLowRisk,
                    color: PRIMARY_BLUE_COLOR,
                    onPressed: () {
                      setState(() {
                        _showLowRisk = !_showLowRisk;
                        _updateDataSource();
                        _panMap();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
