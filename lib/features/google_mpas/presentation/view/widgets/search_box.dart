import 'package:flutter/material.dart';
import 'package:super_market/features/google_mpas/presentation/manager/cubit/google_maps_cubit.dart';
import '../../../data/models/place_model.dart';

class SearchBoxWidget extends StatefulWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final bool showSuggestions;
  final List<PlaceModel> suggestions;
  final GoogleMapsState state;
  final Function(PlaceModel) onSuggestionSelected;
  final Function(String) onSearchChanged;
  final VoidCallback onClearSearch;

  const SearchBoxWidget({
    super.key,
    required this.searchController,
    required this.searchFocusNode,
    required this.showSuggestions,
    required this.suggestions,
    required this.state,
    required this.onSuggestionSelected,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 68,
      left: 16,
      right: 16,
      child: Column(
        children: [
          // Search TextField
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: widget.searchController,
              focusNode: widget.searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search for a place...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(14),
                prefixIcon: const Icon(Icons.search,
                    color: Colors.blue, 
                    size: 22),
                suffixIcon: widget.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[400], size: 20),
                        onPressed: widget.onClearSearch,
                      )
                    : null,
              ),
              onChanged: widget.onSearchChanged,
            ),
          ),

          // Autocomplete Suggestions
          if (widget.showSuggestions && widget.suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.suggestions.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey[200],
                ),
                itemBuilder: (context, index) {
                  final place = widget.suggestions[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 22,
                    ),
                    title: Text(
                      place.mainText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      place.secondaryText,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    onTap: () => widget.onSuggestionSelected(place),
                  );
                },
              ),
            ),

          // Loading indicator for place details
          if (widget.state is MapPlaceLoading && widget.showSuggestions)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('Loading place details...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
