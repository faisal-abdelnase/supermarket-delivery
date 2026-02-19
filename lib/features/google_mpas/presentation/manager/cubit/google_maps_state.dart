part of 'google_maps_cubit.dart';

sealed class GoogleMapsState extends Equatable {
  const GoogleMapsState();

  @override
  List<Object?> get props => [];
}

final class GoogleMapsInitial extends GoogleMapsState {}

final class MapLoading extends GoogleMapsState {}


final class MapLocationLoaded extends GoogleMapsState {
  final LatLng currentLocation;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  const MapLocationLoaded({
    required this.currentLocation,
    this.markers = const {},
    this.polylines = const {},
  });

  @override
  List<Object?> get props => [currentLocation, markers, polylines];

  MapLocationLoaded copyWith({
    LatLng? currentLocation,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
  }) {
    return MapLocationLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }
}



  // New state for autocomplete suggestions
final class MapSearchSuggestions extends GoogleMapsState {
  final List<PlaceModel> suggestions;
  final LatLng currentLocation;
  final Set<Marker> markers;

  const MapSearchSuggestions({
    required this.suggestions,
    required this.currentLocation,
    required this.markers,
  });

  @override
  List<Object?> get props => [suggestions, currentLocation, markers];
}

  // Loading state for place details
final class MapPlaceLoading extends GoogleMapsState {
  final List<PlaceModel> suggestions;
  final LatLng currentLocation;
  final Set<Marker> markers;

  const MapPlaceLoading({
    required this.suggestions,
    required this.currentLocation,
    required this.markers,
  });

  @override
  List<Object?> get props => [suggestions, currentLocation, markers];
}



final class MapSearchSuccess extends GoogleMapsState {
  final LatLng location;
  final String placeName;
  final String address;
  final Set<Marker> markers;

  const MapSearchSuccess({
    required this.location,
    required this.placeName,
    required this.address,
    required this.markers,
  });

  @override
  List<Object?> get props => [location, placeName, address, markers];
}




final class MapTrackingActive extends GoogleMapsState {
  final LatLng orderLocation;
  final LatLng destinationLocation;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final String orderStatus;

  const MapTrackingActive({
    required this.orderLocation,
    required this.destinationLocation,
    required this.markers,
    required this.polylines,
    this.orderStatus = 'On the way',
  });

  @override
  List<Object?> get props => [
        orderLocation,
        destinationLocation,
        markers,
        polylines,
        orderStatus,
      ];

  MapTrackingActive copyWith({
    LatLng? orderLocation,
    LatLng? destinationLocation,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    String? orderStatus,
  }) {
    return MapTrackingActive(
      orderLocation: orderLocation ?? this.orderLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}



final class MapLocationSelectionMode extends GoogleMapsState {
  final LatLng currentLocation;
  final LatLng? selectedLocation;
  final String? address;
  final Set<Marker> markers;
  final Set<Circle> circles;
  final BranchModel? nearestBranch;
  final bool isInDeliveryZone;
  final bool isLoadingAddress;

  const MapLocationSelectionMode({
    required this.currentLocation,
    this.selectedLocation,
    this.address,
    required this.markers,
    required this.circles,
    this.nearestBranch,
    this.isInDeliveryZone = false,
    this.isLoadingAddress = false,
  });

  @override
  List<Object?> get props => [
        currentLocation,
        selectedLocation,
        address,
        markers,
        circles,
        nearestBranch,
        isInDeliveryZone,
        isLoadingAddress,
      ];

  MapLocationSelectionMode copyWith({
    LatLng? currentLocation,
    LatLng? selectedLocation,
    String? address,
    Set<Marker>? markers,
    Set<Circle>? circles,
    BranchModel? nearestBranch,
    bool? isInDeliveryZone,
    bool? isLoadingAddress,
  }) {
    return MapLocationSelectionMode(
      currentLocation: currentLocation ?? this.currentLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      address: address ?? this.address,
      markers: markers ?? this.markers,
      circles: circles ?? this.circles,
      nearestBranch: nearestBranch ?? this.nearestBranch,
      isInDeliveryZone: isInDeliveryZone ?? this.isInDeliveryZone,
      isLoadingAddress: isLoadingAddress ?? this.isLoadingAddress,
    );
  }
}




final class MapError extends GoogleMapsState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object?> get props => [message];
}
