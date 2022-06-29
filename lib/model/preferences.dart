import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const PREF_KEY = "pref_key";

  setFilename(String filename) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, filename);
  }

  getFilename() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PREF_KEY) ?? "prova";
  }
}
