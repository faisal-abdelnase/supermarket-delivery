

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:super_market/core/services/places_service.dart';
import 'package:super_market/features/google_mpas/data/models/branch_model.dart';
import 'package:super_market/features/google_mpas/data/models/place_model.dart';
import 'package:super_market/features/google_mpas/data/models/selected_location_model.dart';


part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(GoogleMapsInitial());

  GoogleMapController? _mapController;

  final PlacesService _placesService = PlacesService();

  // Timer? _trackingTimer;
  Timer? _debounceTimer;

  LatLng? _lastKnownLocation;
  Set<Marker> _currentMarkers = {};

  bool _isSelectionMode = false;

  final List<BranchModel> _branches = BranchesData.getBranches();

  // ───────────────────────────────────────────────────────────────────────────
  // Map Controller
  // ───────────────────────────────────────────────────────────────────────────

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Selection Mode (OLD - kept as is)
  // ───────────────────────────────────────────────────────────────────────────

  void enableSelectionMode() {
    _isSelectionMode = true;
    if (_lastKnownLocation != null) {
      _selectLocationOnMap(_lastKnownLocation!);
    } else {
      getCurrentLocation();
    }
  }

  bool get isSelectionMode => _isSelectionMode;

  void disableSelectionMode() {
    _isSelectionMode = false;
  }

  // Select location on map (when user taps) - OLD VERSION
  Future<void> selectLocationOnMap(LatLng location) async {
    _selectLocationOnMap(location);
  }

  void _selectLocationOnMap(LatLng location) async {
    _lastKnownLocation = location;

    // Add marker for selected location
    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('selected_location'),
        position: location,
        infoWindow: InfoWindow(title: 'Selected Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
    };

    // Emit state with loading address
    emit(MapLocationSelectionMode(
      selectedLocation: location,
      markers: markers,
      circles: {},
      currentLocation: _lastKnownLocation ?? location,
      isLoadingAddress: true,
    ));

    // Get address from coordinates
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      String address = 'Unknown location';
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        List<String> addressParts = [];

        if (place.street != null && place.street!.isNotEmpty) {
          addressParts.add(place.street!);
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressParts.add(place.subLocality!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          addressParts.add(place.administrativeArea!);
        }
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }

        address = addressParts.join(', ');
      }

      emit(MapLocationSelectionMode(
        selectedLocation: location,
        address: address,
        markers: markers,
        circles: {},
        currentLocation: _lastKnownLocation ?? location,
        isLoadingAddress: false,
      ));
    } catch (e) {
      emit(MapLocationSelectionMode(
        selectedLocation: location,
        address:
            'Lat: ${location.latitude.toStringAsFixed(6)}, Lng: ${location.longitude.toStringAsFixed(6)}',
        markers: markers,
        circles: {},
        currentLocation: _lastKnownLocation ?? location,
        isLoadingAddress: false,
      ));
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // NEW: Delivery Location Selection with Branches & Zones
  // ───────────────────────────────────────────────────────────────────────────

  /// Opens the map in delivery selection mode:
  /// - Shows current location
  /// - Displays all branch markers
  /// - Shows colored delivery zone circles
  /// - Drops a pin on current location as default
  Future<void> enterDeliverySelectionMode() async {
    emit(MapLoading());

    try {
      final position = await _fetchDeviceLocation();
      if (position == null) return;

      _lastKnownLocation = position;
      _isSelectionMode = true;
      _applyDeliverySelectionPin(position);

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 13),
      );
    } catch (e) {
      emit(MapError(message: 'Error getting location: $e'));
    }
  }

  /// Called when user taps on the map to select a delivery location
  void onDeliveryMapTapped(LatLng tapped) {
    final currentState = state;
    if (currentState is! MapLocationSelectionMode) return;

    _applyDeliverySelectionPin(
      tapped,
      currentLocation: currentState.currentLocation,
    );

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(tapped, 15),
    );
  }

  /// Confirms and returns the selected delivery location if valid
  SelectedLocationModel? confirmDeliveryLocation() {
    final currentState = state;
    if (currentState is! MapLocationSelectionMode) return null;
    if (currentState.selectedLocation == null) return null;
    if (!currentState.isInDeliveryZone) return null;

    return SelectedLocationModel(
      address: currentState.address ?? 'Unknown address',
      latitude: currentState.selectedLocation!.latitude,
      longitude: currentState.selectedLocation!.longitude,
      assignedBranch: currentState.nearestBranch,
      isInDeliveryZone: true,
    );
  }

  /// Returns list of all branches
  List<BranchModel> get branches => _branches;

  // ───────────────────────────────────────────────────────────────────────────
  // Get Current Location (OLD - kept as is)
  // ───────────────────────────────────────────────────────────────────────────

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
        emit(
            MapError(message: 'Location permissions are permanently denied'));
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

      if (_isSelectionMode) {
        _selectLocationOnMap(currentLocation);
      } else {
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
      }
    } catch (e) {
      emit(MapError(message: 'Error getting location: ${e.toString()}'));
    }
  }

  Future<void> retryGetCurrentLocation() async {
    await getCurrentLocation();
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Autocomplete Search (OLD - kept as is)
  // ───────────────────────────────────────────────────────────────────────────

  void getAutocompleteSuggestions(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      if (_lastKnownLocation != null) {
        if (_isSelectionMode) {
          _selectLocationOnMap(_lastKnownLocation!);
        } else {
          emit(MapLocationLoaded(
            currentLocation: _lastKnownLocation!,
            markers: _currentMarkers,
          ));
        }
      }
      return;
    }

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

      if (_isSelectionMode) {
        // In selection mode, treat search result as selected location
        Set<Marker> markers = {
          Marker(
            markerId: MarkerId('selected_location'),
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

        emit(MapLocationSelectionMode(
          selectedLocation: position,
          address: placeDetails.address,
          markers: markers,
          circles: {},
          currentLocation: _lastKnownLocation ?? position,
          isLoadingAddress: false,
        ));
      } else {
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
      }

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 15),
      );
    } catch (e) {
      emit(MapError(message: 'Error loading place details: $e'));
    }
  }

  void clearSearch() {
    if (_lastKnownLocation != null) {
      if (_isSelectionMode) {
        _selectLocationOnMap(_lastKnownLocation!);
      } else {
        emit(MapLocationLoaded(
          currentLocation: _lastKnownLocation!,
          markers: _currentMarkers,
        ));
      }
    } else {
      getCurrentLocation();
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Private Helpers for NEW Delivery Selection
  // ───────────────────────────────────────────────────────────────────────────

  /// Builds state for delivery selection with branch zones and validation
  void _applyDeliverySelectionPin(LatLng pin, {LatLng? currentLocation}) {
    final anchor = currentLocation ?? _lastKnownLocation ?? pin;
    final nearest = _findNearestBranch(pin);
    final inZone = nearest != null && _isInDeliveryZone(pin, nearest);

    final markers = _buildBranchMarkers();
    markers.add(
      Marker(
        markerId: MarkerId('selected_location'),
        position: pin,
        infoWindow: InfoWindow(title: 'Delivery here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        draggable: true,
        onDragEnd: (newPos) => onDeliveryMapTapped(newPos),
        zIndex: 5,
      ),
    );

    final circles = _buildDeliveryZoneCircles(
      highlightedBranchId: inZone ? nearest.id : null,
    );

    emit(MapLocationSelectionMode(
      currentLocation: anchor,
      selectedLocation: pin,
      markers: markers,
      circles: circles,
      nearestBranch: nearest,
      isInDeliveryZone: inZone,
      isLoadingAddress: true,
    ));

    _resolveAddress(pin);
  }

  Future<void> _resolveAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = 'Unknown location';
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          if (p.street?.isNotEmpty ?? false) p.street!,
          if (p.subLocality?.isNotEmpty ?? false) p.subLocality!,
          if (p.locality?.isNotEmpty ?? false) p.locality!,
          if (p.administrativeArea?.isNotEmpty ?? false) p.administrativeArea!,
          if (p.country?.isNotEmpty ?? false) p.country!,
        ];
        address = parts.join(', ');
      }

      if (state is MapLocationSelectionMode) {
        final s = state as MapLocationSelectionMode;
        emit(s.copyWith(address: address, isLoadingAddress: false));
      }
    } catch (_) {
      if (state is MapLocationSelectionMode) {
        final s = state as MapLocationSelectionMode;
        emit(s.copyWith(
          address:
              '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}',
          isLoadingAddress: false,
        ));
      }
    }
  }

  Set<Marker> _buildBranchMarkers() {
    return _branches
        .map(
          (branch) => Marker(
            markerId: MarkerId('branch_${branch.id}'),
            position: branch.location,
            infoWindow: InfoWindow(
              title: branch.name,
              snippet:
                  '${branch.area} • ${branch.isOpen ? "Open" : "Closed"}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              branch.isOpen
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueOrange,
            ),
            zIndex: 4,
          ),
        )
        .toSet();
  }

  Set<Circle> _buildDeliveryZoneCircles({String? highlightedBranchId}) {
    return _branches
        .map(
          (branch) => Circle(
            circleId: CircleId('zone_${branch.id}'),
            center: branch.location,
            radius: branch.deliveryRadiusKm * 1000,
            fillColor: highlightedBranchId == branch.id
                ? branch.zoneColor.withOpacity(0.25)
                : branch.zoneColor.withOpacity(0.10),
            strokeColor: highlightedBranchId == branch.id
                ? branch.zoneColor.withOpacity(0.9)
                : branch.zoneColor.withOpacity(0.5),
            strokeWidth: highlightedBranchId == branch.id ? 3 : 2,
          ),
        )
        .toSet();
  }

  BranchModel? _findNearestBranch(LatLng location) {
    BranchModel? nearest;
    double minDist = double.infinity;
    for (final branch in _branches) {
      final dist = _distanceBetween(location, branch.location);
      if (dist < minDist) {
        minDist = dist;
        nearest = branch;
      }
    }
    return nearest;
  }

  bool _isInDeliveryZone(LatLng location, BranchModel branch) {
    return _distanceBetween(location, branch.location) <=
        branch.deliveryRadiusKm * 1000;
  }

  double _distanceBetween(LatLng a, LatLng b) {
    return Geolocator.distanceBetween(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
  }

  Future<LatLng?> _fetchDeviceLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      emit(MapError(message: 'Location services are disabled.'));
      return null;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      emit(MapError(message: 'Location permission denied.'));
      return null;
    }

    try {
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
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      emit(MapError(message: 'Error getting location: $e'));
      return null;
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}