import 'package:shared_preferences/shared_preferences.dart';

class SharedprefHelper {
  static Future<void> setFirstTimeFlag(bool isItFirstTime) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('isItFirstTime', isItFirstTime);
  }

  static checkFirstTime() async {
    final sharedPref = await SharedPreferences.getInstance();
    // in the beginning there is no var called isItFirstTime
    final check = sharedPref.get('isItFirstTime') ?? true;
    return check;
  }
}
