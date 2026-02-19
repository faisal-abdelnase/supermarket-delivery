import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class BranchModel {
  final String id;
  final String name;
  final String area;
  final String address;
  final String phone;
  final LatLng location;
  final double deliveryRadiusKm;
  final Color zoneColor;
  final List<String> workingHours;
  final bool isOpen;

  const BranchModel({
    required this.id,
    required this.name,
    required this.area,
    required this.address,
    required this.phone,
    required this.location,
    required this.deliveryRadiusKm,
    required this.zoneColor,
    required this.workingHours,
    required this.isOpen,
  });
}

// Supermarket branches data
class BranchesData {
  static List<BranchModel> getBranches() {
    return [
      BranchModel(
        id: 'branch_1',
        name: 'Fresh Mart Central',
        area: 'Downtown',
        address: '123 Main Street, Downtown',
        phone: '+1 555-0101',
        location: LatLng(37.7749, -122.4194),
        deliveryRadiusKm: 3.0,
        zoneColor: Colors.blue,
        workingHours: ['Mon-Fri: 8AM - 10PM', 'Sat-Sun: 9AM - 9PM'],
        isOpen: true,
      ),
      BranchModel(
        id: 'branch_2',
        name: 'Fresh Mart Northside',
        area: 'North District',
        address: '456 North Ave, North District',
        phone: '+1 555-0102',
        location: LatLng(37.7949, -122.4094),
        deliveryRadiusKm: 2.5,
        zoneColor: Colors.green,
        workingHours: ['Mon-Fri: 7AM - 11PM', 'Sat-Sun: 8AM - 10PM'],
        isOpen: true,
      ),
      BranchModel(
        id: 'branch_3',
        name: 'Fresh Mart Westside',
        area: 'West End',
        address: '789 West Blvd, West End',
        phone: '+1 555-0103',
        location: LatLng(37.7649, -122.4494),
        deliveryRadiusKm: 3.5,
        zoneColor: Colors.orange,
        workingHours: ['Mon-Sun: 8AM - 10PM'],
        isOpen: false,
      ),
      BranchModel(
        id: 'branch_4',
        name: 'Fresh Mart Eastside',
        area: 'East Quarter',
        address: '321 East Road, East Quarter',
        phone: '+1 555-0104',
        location: LatLng(37.7749, -122.3894),
        deliveryRadiusKm: 2.0,
        zoneColor: Colors.purple,
        workingHours: ['Mon-Fri: 9AM - 9PM', 'Sat-Sun: 10AM - 8PM'],
        isOpen: true,
      ),
    ];
  }
}