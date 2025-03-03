import 'package:shared_preferences/shared_preferences.dart';

abstract class FirstDisplaySharedPreference {

  static final String key = "isDisplay";

  static Future<bool> saveData({required bool isDisplay}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(key, isDisplay);
  }

  static Future<bool?> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

}