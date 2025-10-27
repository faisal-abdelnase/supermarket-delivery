import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_market/constant.dart';

abstract class SharedPreferenceFunction {

  

  static Future<bool> saveFirstDisplayData({required bool isDisplay}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(isDisplayKey, isDisplay);
  }

  static Future<bool?> getFirstDisplayData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isDisplayKey);
  }


  static Future<bool> saveLoggedInState({required bool isLoggedIn}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool?> getLoggedInState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isLoggedInKey);
  }

}