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



final class MapError extends GoogleMapsState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object?> get props => [message];
}
