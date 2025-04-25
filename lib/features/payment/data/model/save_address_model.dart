
import 'package:flutter/material.dart';

class AddressModel {
  final String title;
  final String  address;
  final IconData icon;

  AddressModel({required this.title, required this.address, required this.icon});


  static List<AddressModel> addressList = [
  AddressModel(
    title: "Home",
    address: "80 Banastre Road, Southport,SouthportSouthportSouthportSouthportSouthport",
    icon: Icons.home_outlined,
  ),
  AddressModel(
    title: "Work",
    address: "80 Banastre Road, Southport,SouthportSouthportSouthportSouthportSouthport",
    icon: Icons.work_outline,
  ),
  AddressModel(
    title: "Other",
    address: "80 Banastre Road, Southport,SouthportSouthportSouthportSouthportSouthport",
    icon: Icons.location_on_outlined,
  ),
];
}


