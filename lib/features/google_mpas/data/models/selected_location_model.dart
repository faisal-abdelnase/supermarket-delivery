
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'branch_model.dart';

class SelectedLocationModel {
  final String address;
  final double latitude;
  final double longitude;
  final BranchModel? assignedBranch;
  final bool isInDeliveryZone;

  const SelectedLocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
    this.assignedBranch,
    this.isInDeliveryZone = false,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  String get formattedCoordinates =>
      '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';

  @override
  String toString() =>
      'Address: $address | Coordinates: ($latitude, $longitude)';
}