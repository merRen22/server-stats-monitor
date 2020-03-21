import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF23272A),
    buttonColor: const Color(0xFF99AAB5),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFF7289DA),
  buttonColor: const Color(0xFF59F8E8),
  /*
  buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme(
          primary: null,
          primaryVariant: null,
          secondary: null,
          secondaryVariant: null,
          surface: null,
          background: null,
          error: null,
          onPrimary: null,
          onSecondary: null,
          onSurface: null,
          onBackground: null,
          onError: null,
          brightness: null)),
          */
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);

class ThemeNotifier with ChangeNotifier {
  bool _isSunny = true;

  ThemeNotifier() {
    _isSunny = true;
  }

  ThemeData get theme => _isSunny ? lightTheme : darkTheme;

  bool get sunny => _isSunny;

  void toggleSunny() {
    _isSunny = !_isSunny;
    notifyListeners();
  }
}
