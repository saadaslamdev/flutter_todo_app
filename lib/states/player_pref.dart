import 'package:shared_preferences/shared_preferences.dart';

class PlayerPref {
  PlayerPref();

  SharedPreferences? _prefs;
  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setNotes(List<String> notes) {
    _prefs!.setStringList('notes', notes);
  }

  List<String> getNotes() {
    return _prefs!.getStringList('notes') ?? [];
  }

  setIsDarkMode(bool isDarkMode) {
    _prefs!.setBool('isDarkMode', isDarkMode);
  }

  bool getIsDarkMode() {
    return _prefs!.getBool('isDarkMode') ?? false;
  }
}
