import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:speedo_meter/providers/geo_location_provider.dart';

import '../painters/dash_board_painter.dart';
import '../painters/my_location.dart';

class MapAndNavigations extends StatefulWidget {
  const MapAndNavigations({Key? key}) : super(key: key);

  @override
  State<MapAndNavigations> createState() => _MapAndNavigationsState();
}

class _MapAndNavigationsState extends State<MapAndNavigations> {
  late GeoLocationProvider _geoLocationProvider;

  @override
  void initState() {
    _geoLocationProvider = context.read<GeoLocationProvider>();
    Future.delayed(Duration.zero, () {
      _geoLocationProvider.initGeoLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipPath(
        clipper: DashBoardMapClipper(),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _geoLocationProvider.mapController,
              options: MapOptions(
                  // center:_geoLocationProvider.mapController.center ?? LatLng(45.5231, -122.6765),
                  rotation: 0,
                  zoom: 18.0,
                  plugins: []),
              layers: [
                TileLayerOptions(
                  backgroundColor: Colors.black,
                  urlTemplate:
                     'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.jpg',
                 ),
              ],
            ),
            Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(
              painter: DashBoarMapShadowdBlur(),
            ),
                )),
            
            Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(
              painter: DashBoarMapShadowdBlur(innerBlur: true),
            ),
                )),
            Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return MyLocationIndicator(
                    size: constraints.maxWidth * 0.2,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
