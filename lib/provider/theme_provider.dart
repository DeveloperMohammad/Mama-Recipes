import 'package:flutter/material.dart';
import 'package:mama_recipes/constants/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider({required bool isDarkMode}) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> toggleTheme(bool isOn) async {
    final prefs = await SharedPreferences.getInstance();
    if (isOn) {
      themeMode = ThemeMode.dark;
      prefs.setBool('isDarkMode', true);
    } else {
      themeMode = ThemeMode.light;
      prefs.setBool('isDarkMode', false);
    }
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey.shade900,
    primaryColor: Colors.black87,
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.grey.shade900,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        backgroundColor: Colors.black,
        color: Colors.white,
      ),
    )
  );






  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: lightThemeWhiteBackground,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(
      secondary: lightThemeWhiteBackground,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        backgroundColor: Colors.white,
        color: Colors.black,
      ),
    )
  );
}
