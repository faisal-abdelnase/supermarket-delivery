import 'package:flutter/material.dart';

class HintBannerWidget extends StatelessWidget {
  final BuildContext context;

  const HintBannerWidget({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 140,
      left: 16,
      right: 70,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
