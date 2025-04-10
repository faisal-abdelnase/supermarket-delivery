import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {


  List<String> selectedFilters = [];

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {

      selectedFilters.remove(filter);
    } else {

      selectedFilters.add(filter);
    }
    notifyListeners();
  }

  bool isFilterSelected(String filter) {
    return selectedFilters.contains(filter);
  }

  void clearFilters() {
    selectedFilters.clear();
    notifyListeners();
  }
}