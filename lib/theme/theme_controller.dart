import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const String _themePreferenceKey = 'theme_preference';
  late ValueNotifier<ThemeMode> themeMode;
  late SharedPreferences _prefs;
  
  ThemeController() {
    themeMode = ValueNotifier(ThemeMode.system);
    _initPrefs();
  }
  
  // Initialize shared preferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs.getString(_themePreferenceKey);
    if (savedTheme != null) {
      _setThemeFromString(savedTheme);
    }
  }
  
  // Toggle theme between light, dark and system
  void toggleTheme() {
    if (themeMode.value == ThemeMode.system) {
      themeMode.value = ThemeMode.light;
    } else if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }
    _saveThemePreference(themeMode.value);
    notifyListeners();
  }
  
  // Set theme directly
  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
    _saveThemePreference(mode);
    notifyListeners();
  }
  
  // Save theme preference to shared preferences
  Future<void> _saveThemePreference(ThemeMode mode) async {
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      default:
        themeString = 'system';
    }
    await _prefs.setString(_themePreferenceKey, themeString);
  }
  
  // Set theme from saved string value
  void _setThemeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }
    notifyListeners();
  }
  
  // Get icon based on current theme
  IconData getThemeIcon() {
    switch (themeMode.value) {
      case ThemeMode.light:
        return Icons.wb_sunny_outlined;
      case ThemeMode.dark:
        return Icons.nightlight_round;
      default:
        return Icons.settings_display;
    }
  }
  
  // Get string representation of current theme
  String getThemeString() {
    switch (themeMode.value) {
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Escuro';
      default:
        return 'Sistema';
    }
  }
  
  @override
  void dispose() {
    themeMode.dispose();
    super.dispose();
  }
}