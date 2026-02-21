import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/google_mpas/presentation/manager/cubit/google_maps_cubit.dart';

Widget buildTopBar(BuildContext context, TextEditingController searchController, FocusNode searchFocusNode) {
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
                  Text('Search or tap the map',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                ],
              ),
            ),
            // My location
            GestureDetector(
              onTap: () {
                searchController.clear();
                searchFocusNode.unfocus();
                context.read<GoogleMapsCubit>().enterDeliverySelectionMode();
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.my_location,
                    size: 19, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }