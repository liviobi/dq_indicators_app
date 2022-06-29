import 'package:flutter/material.dart';
import 'package:frontend/model/preferences.dart';

class SelectedFileModel extends ChangeNotifier {
  String _filename = "provs";
  final Preferences _preferences = Preferences();

  SelectedFileModel() {
    getPreferences();
  }

  getPreferences() async {
    _filename = await _preferences.getFilename();
    notifyListeners();
  }

  String get filename => _filename;

  set filename(String value) {
    _filename = value;
    _preferences.setFilename(value);
    notifyListeners();
  }
}
