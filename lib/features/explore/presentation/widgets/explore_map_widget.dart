import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Map widget for the explore screen
class ExploreMapWidget extends StatelessWidget {
  final LatLng center;
  final double zoom;
  final MapController mapController;
  final List<Marker> markers;
  final VoidCallback onMapReady;

  const ExploreMapWidget({
    super.key,
    required this.center,
    required this.zoom,
    required this.mapController,
    required this.markers,
    required this.onMapReady,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: zoom,
        minZoom: 10,
        maxZoom: 18,
        onMapReady: onMapReady,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.sahada.app',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}
