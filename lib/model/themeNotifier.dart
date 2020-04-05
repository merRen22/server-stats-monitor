import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkTheme = ThemeData(
    //primarySwatch: Colors.white,
    primaryColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    backgroundColor: const Color(0xFF23272A),
    buttonColor: const Color(0xFF7289DA),

    accentColor: const Color(0xFF7289DA),
  buttonTheme: ButtonThemeData(
    shape: StadiumBorder(),
    buttonColor: Colors.green,
    textTheme: ButtonTextTheme.accent
  ),
    );

final lightTheme = ThemeData(
  //primarySwatch: Colors.black,
  primaryColor: Colors.white,
  iconTheme: IconThemeData(
      color: Colors.black
    ),
  backgroundColor: const Color(0xFF7289DA),
  buttonColor: const Color(0xFF59F8E8),

  accentColor: const Color(0xFFda727e),
  buttonTheme: ButtonThemeData(
    shape: StadiumBorder(),
    buttonColor: Colors.green,
    textTheme: ButtonTextTheme.accent
  ),
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
);

class ThemeNotifier with ChangeNotifier {
  bool _isSunny = true;

  SharedPreferences _prefs;
  
  void checkTheme() async {
    _prefs = await SharedPreferences.getInstance();

    print(_prefs.getBool("isLightTheme"));

    _isSunny = _prefs.getBool("isLightTheme") == null
      ?true
      :_prefs.getBool("isLightTheme");

    notifyListeners();
  }

  ThemeNotifier() {
    checkTheme();
  }

  ThemeData get theme => _isSunny ? lightTheme : darkTheme;

  bool get sunny => _isSunny;

  void toggleSunny() async {
    _isSunny = !_isSunny;

    await _prefs.setBool("isLightTheme", _isSunny);

    notifyListeners();
  }
}
