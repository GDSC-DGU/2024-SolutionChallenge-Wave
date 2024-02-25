import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:wave/common/const/colors.dart';

MapDataLabelSettings getDataLabelSettings(double currentZoomLevel) {
  print('currentZoomLevel: $currentZoomLevel');
  int zoomCase;

  if (currentZoomLevel >= 7) {
    zoomCase = 7;
  } else if (currentZoomLevel >= 5) {
    zoomCase = 5;
  } else if (currentZoomLevel >= 4) {
    zoomCase = 4;
  } else {
    zoomCase = 0;
  }

  switch (zoomCase) {
    case 7:
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.visible,
        textStyle: TextStyle(
          fontFamily: 'HelveticaNeue',
          color: MAP_COUNTRY_COLOR,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      );
    case 5:
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.ellipsis,
        textStyle: TextStyle(
          fontFamily: 'HelveticaNeue',
          color: MAP_COUNTRY_COLOR,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      );
    case 4:
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.hide,
        textStyle: TextStyle(
          fontFamily: 'HelveticaNeue',
          color: MAP_COUNTRY_COLOR,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      );
    default:
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.hide,
        textStyle: TextStyle(
          fontFamily: 'HelveticaNeue',
          color: MAP_COUNTRY_COLOR,
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      );
  }
}
