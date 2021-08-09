import 'package:shared_preferences/shared_preferences.dart';
import 'package:updatable/updatable.dart';

class Settings with Updatable {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  late int _selectedOption;

  set selectedOption(int selectedOption) {
    changeState(() {
      _selectedOption = selectedOption;
    });
    _saveToPrefs();
  }

  int get selectedOption {
    return _selectedOption;
  }

  Settings._create({required int selectedOption})
      : _selectedOption = selectedOption;

  static Future<Settings> getInstance({required int defaultOption}) async {
    final settings = Settings._create(selectedOption: defaultOption);
    await settings._loadFromPerferences();
    return settings;
  }

  Future<void> _loadFromPerferences() async {
    final preferences = await _preferences;
    _selectedOption = preferences.getInt("selectedOption") ?? _selectedOption;
  }

  Future<void> _saveToPrefs() async {
    final preferences = await _preferences;
    preferences.setInt("selectedOption", _selectedOption);
  }
}
