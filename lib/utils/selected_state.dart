// List<bool> selectedStates = [false, false, false]; // Assuming you have 3 checkboxes initially

import 'package:flutter/material.dart';

class SelectionState extends ChangeNotifier {
  List<bool> selectedStates = [false, false, false]; // Assuming you have 3 checkboxes initially

  void setSelectedStates(List<bool> newSelectedStates) {
    selectedStates = newSelectedStates;
    notifyListeners();
  }
}