import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:super_market/core/services/places_service.dart';
import 'package:super_market/features/google_mpas/data/models/place_model.dart';


part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(GoogleMapsInitial());

  GoogleMapController? _mapController;

  final PlacesService _placesService = PlacesService();

  // Timer? _trackingTimer;
  Timer? _debounceTimer;

  LatLng? _lastKnownLocation;
  Set<Marker> _currentMarkers = {};

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }



  // Get current location
  Future<void> getCurrentLocation() async {
    emit(MapLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(MapError(message: 'Location services are disabled.'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(MapError(message: 'Location permissions are denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(MapError(
            message: 'Location permissions are permanently denied'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(
        Duration(seconds: 15),
        onTimeout: () async {
        
          return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
          );
        },
      );

      LatLng currentLocation = LatLng(position.latitude, position.longitude);
      _lastKnownLocation = currentLocation;

      // Add marker for current location
      Set<Marker> markers = {
        Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation,
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      };
      
      _currentMarkers = markers;

      emit(MapLocationLoaded(
        currentLocation: currentLocation,
        markers: markers,
      ));

      // Animate camera to current location
      if (_mapController != null) {
        Future.delayed(Duration(milliseconds: 500), () {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(currentLocation, 14),
          );
        });
      }
    } catch (e) {
      emit(MapError(message: 'Error getting location: ${e.toString()}'));
    }
  }

  // Retry getting current location
  Future<void> retryGetCurrentLocation() async {
    await getCurrentLocation();
  }





  // Get autocomplete suggestions with debounce
  void getAutocompleteSuggestions(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      // Return to previous state if query is empty
      if (_lastKnownLocation != null) {
        emit(MapLocationLoaded(
          currentLocation: _lastKnownLocation!,
          markers: _currentMarkers,
        ));
      }
      return;
    }

    // Debounce for 500ms
    _debounceTimer = Timer(Duration(milliseconds: 500), () async {
      try {
        final suggestions =
            await _placesService.getAutocompleteSuggestions(query);

        emit(MapSearchSuggestions(
          suggestions: suggestions,
          currentLocation: _lastKnownLocation ?? LatLng(37.7749, -122.4194),
          markers: _currentMarkers,
        ));
      } catch (e) {
        emit(MapError(message: 'Error loading suggestions: $e'));
      }
    });
  }




  // Select a place from suggestions
  Future<void> selectPlace(String placeId) async {
    final currentState = state;
    
    if (currentState is MapSearchSuggestions) {
      emit(MapPlaceLoading(
        suggestions: currentState.suggestions,
        currentLocation: currentState.currentLocation,
        markers: currentState.markers,
      ));
    }

    try {
      final placeDetails = await _placesService.getPlaceDetails(placeId);

      LatLng position = LatLng(
        placeDetails.latitude,
        placeDetails.longitude,
      );

      _lastKnownLocation = position;

      // Add marker for selected place
      _currentMarkers = {
        Marker(
          markerId: MarkerId('selected_place'),
          position: position,
          infoWindow: InfoWindow(
            title: placeDetails.name,
            snippet: placeDetails.address,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      };

      emit(MapSearchSuccess(
        location: position,
        placeName: placeDetails.name,
        address: placeDetails.address,
        markers: _currentMarkers,
      ));

      // Animate camera to selected location
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 15),
      );
    } catch (e) {
      emit(MapError(message: 'Error loading place details: $e'));
    }
  }

  // Clear search and return to current location
  void clearSearch() {
    if (_lastKnownLocation != null) {
      emit(MapLocationLoaded(
        currentLocation: _lastKnownLocation!,
        markers: _currentMarkers,
      ));
    } else {
      getCurrentLocation();
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

}
