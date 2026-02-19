
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:super_market/features/google_mpas/data/models/branch_model.dart';
import 'package:super_market/features/google_mpas/presentation/manager/cubit/google_maps_cubit.dart';

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

    Future.microtask(
        () => context.read<GoogleMapsCubit>().enterDeliverySelectionMode());
  }

  @override
  void dispose() {
    _cardAnim.dispose();
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
                  backgroundColor: Colors.red),
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

          if (state is MapLocationSelectionMode) {
            sel = state;
            initialPos = state.currentLocation;
            markers = state.markers;
            circles = state.circles;
          } else if (state is MapLocationLoaded) {
            initialPos = state.currentLocation;
            markers = state.markers;
          }

          return GestureDetector(
            onTap: () => setState(() => _showBranches = false),
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
                    setState(() => _showBranches = false);
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
                _buildTopBar(context),

                // ── Instruction hint ──────────────────────────────────────
                if (sel != null && sel.selectedLocation == null)
                  _buildHint(),

                // ── Branches toggle button ────────────────────────────────
                if (!_showBranches)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 76,
                    right: 16,
                    child: _buildBranchesButton(),
                  ),

                // ── Branches list panel ───────────────────────────────────
                if (_showBranches)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 76,
                    right: 16,
                    child: _buildBranchesPanel(context),
                  ),

                // ── Confirm card ──────────────────────────────────────────
                if (sel != null && sel.selectedLocation != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: _buildConfirmCard(context, sel),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Top bar ─────────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Back
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    size: 17, color: Colors.black87),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Delivery Location',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900])),
                  Text('Tap the map or drag the pin',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey[500])),
                ],
              ),
            ),
            // My location
            GestureDetector(
              onTap: () => context.read<GoogleMapsCubit>().enterDeliverySelectionMode(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.my_location,
                    size: 19, color: Color(0xFF4CAF50)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Hint banner ──────────────────────────────────────────────────────────────

  Widget _buildHint() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 76,
      left: 16,
      right: 70,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1565C0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.touch_app, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Tap anywhere inside a colored zone',
                style:
                    TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Branches toggle button ───────────────────────────────────────────────────

  Widget _buildBranchesButton() {
    return GestureDetector(
      onTap: () => setState(() => _showBranches = true),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.store,
                size: 17, color: Color(0xFF4CAF50)),
            const SizedBox(width: 5),
            Text('Branches',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }

  // ── Branches list panel ──────────────────────────────────────────────────────

  Widget _buildBranchesPanel(BuildContext context) {
    final branches = context.read<GoogleMapsCubit>().branches;

    return Container(
      width: 255,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.52),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 18,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding:
                const EdgeInsets.fromLTRB(14, 12, 8, 8),
            child: Row(
              children: [
                const Icon(Icons.store_mall_directory,
                    size: 18, color: Color(0xFF4CAF50)),
                const SizedBox(width: 7),
                Text('Our Branches',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900])),
                const Spacer(),
                GestureDetector(
                  onTap: () =>
                      setState(() => _showBranches = false),
                  child: const Icon(Icons.close,
                      size: 17, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: branches.length,
              itemBuilder: (_, i) =>
                  _branchCard(context, branches[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _branchCard(BuildContext context, BranchModel branch) {
    return GestureDetector(
      onTap: () {
        setState(() => _showBranches = false);
        context.read<GoogleMapsCubit>().onDeliveryMapTapped(branch.location);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: branch.isOpen
              ? branch.zoneColor.withOpacity(0.05)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: branch.isOpen
                  ? branch.zoneColor.withOpacity(0.25)
                  : Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                        color: branch.zoneColor,
                        shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(branch.name,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700))),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: branch.isOpen
                        ? Colors.green[50]
                        : Colors.orange[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    branch.isOpen ? 'Open' : 'Closed',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: branch.isOpen
                            ? Colors.green[700]
                            : Colors.orange[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(children: [
              Icon(Icons.location_on_outlined,
                  size: 12, color: Colors.grey[400]),
              const SizedBox(width: 3),
              Text(branch.area,
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey[600])),
            ]),
            const SizedBox(height: 3),
            Row(children: [
              Icon(Icons.delivery_dining,
                  size: 12, color: Colors.grey[400]),
              const SizedBox(width: 3),
              Text('${branch.deliveryRadiusKm} km radius',
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey[600])),
            ]),
          ],
        ),
      ),
    );
  }

  // ── Confirm card ─────────────────────────────────────────────────────────────

  Widget _buildConfirmCard(
      BuildContext context, MapLocationSelectionMode state) {
    final inZone = state.isInDeliveryZone;
    final branch = state.nearestBranch;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.13),
              blurRadius: 28,
              offset: const Offset(0, -4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 14),

            // Address row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: inZone
                        ? const Color(0xFF4CAF50).withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    inZone ? Icons.location_on : Icons.location_off,
                    color: inZone ? const Color(0xFF4CAF50) : Colors.red,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivery Address',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500])),
                      const SizedBox(height: 3),
                      if (state.isLoadingAddress)
                        Row(children: [
                          const SizedBox(
                              width: 13,
                              height: 13,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF4CAF50))),
                          const SizedBox(width: 7),
                          Text('Getting address...',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 13)),
                        ])
                      else
                        Text(
                          state.address ?? 'Unknown location',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      const SizedBox(height: 3),
                      if (state.selectedLocation != null)
                        Text(
                          '${state.selectedLocation!.latitude.toStringAsFixed(5)}, '
                          '${state.selectedLocation!.longitude.toStringAsFixed(5)}',
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey[400]),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Branch info chip
            if (branch != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: inZone
                      ? branch.zoneColor.withOpacity(0.06)
                      : Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: inZone
                        ? branch.zoneColor.withOpacity(0.3)
                        : Colors.red.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: inZone
                            ? branch.zoneColor.withOpacity(0.15)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(
                          inZone ? Icons.store : Icons.store_outlined,
                          size: 17,
                          color: inZone ? branch.zoneColor : Colors.red),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inZone
                                ? 'Served by ${branch.name}'
                                : 'Outside all delivery zones',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: inZone
                                    ? Colors.grey[850]
                                    : Colors.red[700]),
                          ),
                          Text(
                            inZone
                                ? '${branch.area} • ${branch.isOpen ? "Open now" : "Currently closed"}'
                                : 'Move the pin inside a colored area',
                            style: TextStyle(
                                fontSize: 12,
                                color: inZone
                                    ? Colors.grey[500]
                                    : Colors.red[400]),
                          ),
                        ],
                      ),
                    ),
                    if (inZone)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: branch.isOpen
                              ? Colors.green[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          branch.isOpen ? 'Open' : 'Closed',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: branch.isOpen
                                  ? Colors.green[700]
                                  : Colors.orange[700]),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 14),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: (inZone && !state.isLoadingAddress)
                    ? () {
                        final result = context
                            .read<GoogleMapsCubit>()
                            .confirmDeliveryLocation();
                        if (result != null) {
                          Navigator.pop(context, result);
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: inZone
                      ? const Color(0xFF2E7D32)
                      : Colors.grey[300],
                  foregroundColor: Colors.white,
                  elevation: inZone ? 2 : 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(inZone ? Icons.check_circle : Icons.block,
                        size: 19),
                    const SizedBox(width: 7),
                    Text(
                      inZone
                          ? 'Confirm Delivery Here'
                          : 'Outside Delivery Zone',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
