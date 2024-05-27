import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberState extends StateNotifier<int> {
  NumberState() : super(0) {
    _loadNumber();
  }

  Future<void> _loadNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getInt('number') ?? 0;
  }

  Future<void> incrementNumber() async {
    state++;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('number', state);
    state = state;
  }
}

final numberProvider = StateNotifierProvider<NumberState, int>((ref) {
  return NumberState();
});
