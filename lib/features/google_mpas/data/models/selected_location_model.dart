import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedLocationModel {
  final String address;
  final double latitude;
  final double longitude;

  SelectedLocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  @override
  String toString() {
    return 'Address: $address\nCoordinates: ($latitude, $longitude)';
  }
}