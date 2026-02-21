
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/top_bar.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/hint_banner.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/branches_button.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/branches_panel.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/confirm_card.dart';
import 'package:super_market/features/google_mpas/presentation/view/widgets/search_box.dart';
import '../manager/cubit/google_maps_cubit.dart';
import '../../data/models/place_model.dart';

class DeliveryMapView extends StatefulWidget {
  const DeliveryMapView({super.key});

  static const String routeId = '/deliveryMap';

  @override
  State<DeliveryMapView> createState() => _DeliveryMapViewState();
}

class _DeliveryMapViewState extends State<DeliveryMapView>
    with SingleTickerProviderStateMixin {
  late AnimationController _cardAnim;
  late Animation<Offset> _slideAnim;
  bool _showBranches = false;

  // Search
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();

    _cardAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _cardAnim, curve: Curves.easeOutCubic));

    _searchFocusNode.addListener(() {
      setState(() {
        _showSuggestions = _searchFocusNode.hasFocus;
      });
    });

    Future.microtask(() =>
        context.read<GoogleMapsCubit>().enterDeliverySelectionMode());
  }

  @override
  void dispose() {
    _cardAnim.dispose();
    _searchController.dispose();
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
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          if (state is MapLocationSelectionMode &&
              state.selectedLocation != null &&
              !state.isLoadingAddress) {
            _cardAnim.forward();
          } else if (state is MapLoading) {
            _cardAnim.reverse();
          }
        },
        builder: (context, state) {
          // Resolve display values for map
          LatLng initialPos = const LatLng(37.7749, -122.4194);
          Set<Marker> markers = {};
          Set<Circle> circles = {};
          Set<Polyline> polylines = {};
          MapLocationSelectionMode? sel;
          List<PlaceModel> suggestions = [];

          if (state is MapLocationSelectionMode) {
            sel = state;
            initialPos = state.currentLocation;
            markers = state.markers;
            circles = state.circles;
          } else if (state is MapLocationLoaded) {
            initialPos = state.currentLocation;
            markers = state.markers;
          } else if (state is MapSearchSuggestions) {
            initialPos = state.currentLocation;
            markers = state.markers;
            suggestions = state.suggestions;
          } else if (state is MapPlaceLoading) {
            initialPos = state.currentLocation;
            markers = state.markers;
            suggestions = state.suggestions;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                _showBranches = false;
                _showSuggestions = false;
              });
              _searchFocusNode.unfocus();
            },
            child: Stack(
              children: [
                // ── Map ──────────────────────────────────────────────────
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: initialPos, zoom: 13),
                  onMapCreated: (c) =>
                      context.read<GoogleMapsCubit>().setMapController(c),
                  markers: markers,
                  circles: circles,
                  polylines: polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  onTap: (latlng) {
                    setState(() {
                      _showBranches = false;
                      _showSuggestions = false;
                    });
                    _searchFocusNode.unfocus();
                    context.read<GoogleMapsCubit>().onDeliveryMapTapped(latlng);
                  },
                ),

                // ── Loading ───────────────────────────────────────────────
                if (state is MapLoading)
                  const ColoredBox(
                    color: Color(0x44000000),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF4CAF50))),
                  ),

                // ── Top bar ───────────────────────────────────────────────
                buildTopBar(context, _searchController, _searchFocusNode),

                // ── Search Box ────────────────────────────────────────────
                SearchBoxWidget(
                  searchController: _searchController,
                  searchFocusNode: _searchFocusNode,
                  showSuggestions: _showSuggestions,
                  suggestions: suggestions,
                  state: state,
                  onSuggestionSelected: (place) {
                    _searchController.text = place.description;
                    _searchFocusNode.unfocus();
                    setState(() {
                      _showSuggestions = false;
                    });
                    context.read<GoogleMapsCubit>().selectPlace(place.placeId);
                  },
                  onSearchChanged: (value) {
                    setState(() {
                      _showSuggestions = value.isNotEmpty;
                    });
                    context.read<GoogleMapsCubit>().getAutocompleteSuggestions(value);
                  },
                  onClearSearch: () {
                    _searchController.clear();
                    context.read<GoogleMapsCubit>().clearSearch();
                    setState(() {
                      _showSuggestions = false;
                    });
                  },
                ),

                // ── Instruction hint ──────────────────────────────────────
                if (sel != null &&
                    sel.selectedLocation == null &&
                    !_showSuggestions)
                  HintBannerWidget(context: context),

                // ── Branches toggle button ────────────────────────────────
                if (!_showBranches && !_showSuggestions)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 140,
                    right: 16,
                    child: BranchesButtonWidget(
                      onTap: () => setState(() => _showBranches = true),
                    ),
                  ),

                // ── Branches list panel ───────────────────────────────────
                if (_showBranches)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 140,
                    right: 16,
                    child: BranchesPanelWidget(
                      branches: context.read<GoogleMapsCubit>().branches,
                      onClose: () => setState(() => _showBranches = false),
                      onSelectBranch: (branch) {
                        setState(() => _showBranches = false);
                        context.read<GoogleMapsCubit>().onDeliveryMapTapped(branch.location);
                      },
                    ),
                  ),

                // ── Confirm card ──────────────────────────────────────────
                if (sel != null &&
                    sel.selectedLocation != null &&
                    !_showSuggestions)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: ConfirmCardWidget(
                        state: sel,
                        onConfirm: () {
                          final result = context
                              .read<GoogleMapsCubit>()
                              .confirmDeliveryLocation();
                          if (result != null) {
                            Navigator.pop(context, result);
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}