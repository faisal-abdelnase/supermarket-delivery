import 'package:flutter/material.dart';
import '../../../data/models/branch_model.dart';

class BranchCardWidget extends StatelessWidget {
  final BranchModel branch;
  final VoidCallback onTap;

  const BranchCardWidget({
    super.key,
    required this.branch,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                        color: branch.zoneColor, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(branch.name,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700))),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        branch.isOpen ? Colors.green[50] : Colors.orange[50],
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
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ]),
            const SizedBox(height: 3),
            Row(children: [
              Icon(Icons.delivery_dining, size: 12, color: Colors.grey[400]),
              const SizedBox(width: 3),
              Text('${branch.deliveryRadiusKm} km radius',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ]),
          ],
        ),
      ),
    );
  }
}
