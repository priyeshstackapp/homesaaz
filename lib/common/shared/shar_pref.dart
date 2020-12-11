import 'package:homesaaz/main.dart';

// ignore: camel_case_types
class Shared_Preferences {

  //int
  static Future prefSetInt(String key, int value) async {
    
    prefs.setInt(key, value);
  }

  static Future<bool> checkKey(String key) async {
    
    return prefs.containsKey(key);
  }

  static Future<int> prefGetInt(String key, int intDef) async {
    

    if (prefs.getInt(key) != null) {
      return prefs.getInt(key);
    } else {
      return intDef;
    }
  }

  //bool
  static Future prefSetBool(String key, bool value) async {
    
    prefs.setBool(key, value);
  }

  static Future<bool> prefGetBool(String key, bool boolDef) async {
    
    if (prefs.getBool(key) != null) {
      return prefs.getBool(key);
    } else {
      return boolDef;
    }
  }

  //String
  static Future prefSetString(String key, String value) async {
    
    prefs.setString(key, value);
  }

  static Future<String> prefGetString(String key, String strDef) async {
    
    if (prefs.getString(key) != null) {
      return prefs.getString(key);
    } else {
      return strDef;
    }
  }

  //Double
  static Future prefSetDouble(String key, double value) async {
    
    prefs.setDouble(key, value);
  }

  static Future<double> prefGetDouble(String key, double douDef) async {
    
    if (prefs.getDouble(key) != null) {
      return prefs.getDouble(key);
    } else {
      return douDef;
    }
  }

  static Future clearPref() async {
    
    prefs.clear();
  }

  static Future clearKeyPref(String key) async {
    
    prefs.remove(key);
  }
}
