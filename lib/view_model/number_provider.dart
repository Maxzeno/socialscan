import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberProvider with ChangeNotifier {
  int _number = 0;

  NumberProvider(){
    _loadNumber();
  }

  int get number => _number;

  Future<void> _loadNumber() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _number = prefs.getInt('number')?? 0;
    notifyListeners();
  }

  void incrementNumber() async{
    _number++;
    notifyListeners(); // Notify listeners to update widgets
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('number', _number);
  }
}