import 'package:flutter/material.dart';
import 'package:super_market/features/google_mpas/presentation/manager/cubit/google_maps_cubit.dart';

class ConfirmCardWidget extends StatelessWidget {
  final MapLocationSelectionMode state;
  final VoidCallback onConfirm;

  const ConfirmCardWidget({
    super.key,
    required this.state,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
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
                              fontSize: 11, color: Colors.grey[500])),
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
                                  color: Colors.grey[400], fontSize: 13)),
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
                    ? onConfirm
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      inZone ? const Color(0xFF2E7D32) : Colors.grey[300],
                  foregroundColor: Colors.white,
                  elevation: inZone ? 2 : 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(inZone ? Icons.check_circle : Icons.block, size: 19),
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
