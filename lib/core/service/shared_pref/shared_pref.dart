import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static final SharedPref _instance = SharedPref._();

  factory SharedPref() => _instance;

  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    await prefs!.setBool(key, value);
  }

  static bool getBool(String key) {
    return prefs!.getBool(key) ?? false;
  }
}
