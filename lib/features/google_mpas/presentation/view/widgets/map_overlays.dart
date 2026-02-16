import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/google_mpas/data/models/place_model.dart';
import 'package:super_market/features/google_mpas/data/models/selected_location_model.dart';
import 'package:super_market/features/google_mpas/presentation/manager/cubit/google_maps_cubit.dart';

class MapOverlays extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final bool showSuggestions;
  final List<PlaceModel> suggestions;
  final GoogleMapsState state;
  final VoidCallback onClear;
  final void Function(String) onChanged;
  final void Function(PlaceModel) onSuggestionTap;

  final bool isSelectionMode;

  const MapOverlays({
    super.key,
    required this.searchController,
    required this.searchFocusNode,
    required this.showSuggestions,
    required this.suggestions,
    required this.state,
    required this.onClear,
    required this.onChanged,
    required this.onSuggestionTap, required this.isSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search for a place...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                      prefixIcon: Icon(Icons.search, color: Colors.blue),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey),
                              onPressed: onClear,
                            )
                          : null,
                    ),
                    onChanged: onChanged,
                  ),
                ),

                if (showSuggestions && suggestions.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: suggestions.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      itemBuilder: (context, index) {
                        final place = suggestions[index];
                        return ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          title: Text(
                            place.mainText,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            place.secondaryText,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          onTap: () => onSuggestionTap(place),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          if (state is MapPlaceLoading && showSuggestions)
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('Loading place details...'),
                    ],
                  ),
                ),
              ),
            ),




          // Selection Mode Instructions
          if (isSelectionMode && state is! MapLocationSelectionMode)
            Positioned(
              top: 80,
              left: 15,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tap on the map to select a location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),





          // Selected Location Card
          if (state is MapLocationSelectionMode)
              Positioned(
                bottom: 20,
                left: 15,
                right: 15,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 28,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                if ((state as MapLocationSelectionMode).isLoadingAddress)
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Getting address...',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    (state as MapLocationSelectionMode).address ?? 'Unknown address',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                SizedBox(height: 4),
                                Text(
                                  'Lat: ${(state as MapLocationSelectionMode).selectedLocation.latitude.toStringAsFixed(6)}, '
                                  'Lng: ${(state as MapLocationSelectionMode).selectedLocation.longitude.toStringAsFixed(6)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (state as MapLocationSelectionMode).isLoadingAddress
                              ? null
                              : () {
                                  // Return selected location
                                  final selectedLocation =
                                      SelectedLocationModel(
                                    address: (state as MapLocationSelectionMode).address ?? 'Unknown address',
                                    latitude: (state as MapLocationSelectionMode).selectedLocation.latitude,
                                    longitude: (state as MapLocationSelectionMode).selectedLocation.longitude,
                                  );
                                  Navigator.pop(context, selectedLocation);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Confirm Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),



          if (state is MapSearchSuccess && !showSuggestions)
            Positioned(
              bottom: 100,
              left: 15,
              right: 15,
              child: _PlaceDetailsCard(state: state as MapSearchSuccess),
            ),
        ],
      ),
    );
  }
}








class _PlaceDetailsCard extends StatelessWidget {
  final MapSearchSuccess state;

  const _PlaceDetailsCard({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
                size: 28,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.placeName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      state.address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.directions),
                  label: Text('Directions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<GoogleMapsCubit>().clearSearch();
                  },
                  icon: Icon(Icons.close),
                  label: Text('Clear'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
