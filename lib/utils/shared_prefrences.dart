import 'package:shared_preferences/shared_preferences.dart';

class CompleteAccountPreference {
  Future<void> setAccountSetupComplete(bool isComplete) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('accountSetupComplete', isComplete);
  }

  Future<bool> isAccountSetupComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('accountSetupComplete') ?? false;
  }
}
