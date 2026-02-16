import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:super_market/features/google_mpas/data/models/place_model.dart';
import 'package:super_market/features/google_mpas/presentation/manager/cubit/google_maps_cubit.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/map_overlays.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.isSelectionMode});

  static const String mapScreenID = "/mapScreen";
  final bool isSelectionMode;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late TextEditingController searchController;
  GoogleMapController? mapController;

  final FocusNode _searchFocusNode = FocusNode();
  bool _showSuggestions = false;


  @override
  void initState() {
    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        if (!mounted) return;
        context.read<GoogleMapsCubit>().getCurrentLocation();
      });
    });

    _searchFocusNode.addListener(() {
      setState(() {
        _showSuggestions = _searchFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  Future<void> _refreshLocation() async {
    if (!mounted) return;
    await context.read<GoogleMapsCubit>().retryGetCurrentLocation();
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GoogleMapsCubit, GoogleMapsState>(
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: _refreshLocation,
                ),
                duration: Duration(seconds: 5),
              ),
            );
          }
        },
        builder: (context, state) {
          LatLng initialPosition = LatLng(37.7749, -122.4194);
          Set<Marker> markers = {};
          Set<Polyline> polylines = {};
          List<PlaceModel> suggestions = [];

          if (state is MapLocationLoaded) {
            initialPosition = state.currentLocation;
            markers = state.markers;
            polylines = state.polylines;
          } else if (state is MapLocationSelectionMode) {
            initialPosition = state.selectedLocation;
            markers = state.markers;
          } else if (state is MapSearchSuggestions) {
            initialPosition = state.currentLocation;
            markers = state.markers;
            suggestions = state.suggestions;
          } else if (state is MapPlaceLoading) {
            initialPosition = state.currentLocation;
            markers = state.markers;
            suggestions = state.suggestions;
          } else if (state is MapSearchSuccess) {
            initialPosition = state.location;
            markers = state.markers;
          }


          else if (state is MapLoading) {
            return Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              );
          }

          return SafeArea(
            top: true,
            child: GestureDetector(
              onTap: () {
                _searchFocusNode.unfocus();
                  setState(() {
                    _showSuggestions = false;
                  });
              },
              child: Stack(
              
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: 14,
                  ),
              
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                    context.read<GoogleMapsCubit>().setMapController(controller);
                  },
              
                  markers: markers,
                  polylines: polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,

                  onTap: widget.isSelectionMode
                      ? (LatLng location) {
                          _searchFocusNode.unfocus();
                          setState(() {
                            _showSuggestions = false;
                          });
                          context.read<GoogleMapsCubit>().selectLocationOnMap(location);
                        }
                      : (_) {
                          _searchFocusNode.unfocus();
                          setState(() {
                            _showSuggestions = false;
                          });
                        },
                ),





                MapOverlays(
                  isSelectionMode: widget.isSelectionMode,
                  searchController: searchController,
                  searchFocusNode: _searchFocusNode,
                  showSuggestions: _showSuggestions,
                  suggestions: suggestions,
                  state: state,
                  onClear: () {
                    searchController.clear();
                    context.read<GoogleMapsCubit>().clearSearch();
                    setState(() {
                      _showSuggestions = false;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _showSuggestions = value.isNotEmpty;
                    });
                    context.read<GoogleMapsCubit>().getAutocompleteSuggestions(value);
                  },
                  onSuggestionTap: (place) {
                    searchController.text = place.description;
                    _searchFocusNode.unfocus();
                    setState(() {
                      _showSuggestions = false;
                    });
                    context.read<GoogleMapsCubit>().selectPlace(place.placeId);
                  },
                ),


                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshLocation,
        tooltip: 'Refresh Location',
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
