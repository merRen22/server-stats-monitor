import 'package:flutter/material.dart';
import 'package:server_sync/models.dart' show ThemeColor;
import 'package:shared_preferences/shared_preferences.dart';

themeMakerLight(color) {
  
  if(color == Colors.white){
    return ThemeData.light();
  }

  if(color == Colors.black){
    return ThemeData.dark();
  }

  Color softColor = color[400];

  Color mediumColor = color[600];

  Color hardColor = color[800];

  return ThemeData(
      primarySwatch: color,
      scaffoldBackgroundColor: softColor,
      dialogBackgroundColor: softColor,
      backgroundColor: softColor,
      bottomAppBarColor: softColor,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: softColor),
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: color,
        secondary: hardColor,
      ),
      cardTheme: CardTheme(color: mediumColor),
    );
    }

  final appColors = [
    ThemeColor(Colors.black,'black'),
    ThemeColor(Colors.blue,'blue'),
    ThemeColor(Colors.cyan,'cyan'),
    ThemeColor(Colors.green,'green'),
    ThemeColor(Colors.grey,'grey'),
    ThemeColor(Colors.indigo,'indigo'),
    ThemeColor(Colors.lime,'lime'),
    ThemeColor(Colors.pink,'pink'),
    ThemeColor(Colors.purple,'purple'),
    ThemeColor(Colors.red,'red'),
    ThemeColor(Colors.white,'white'),
  ];

class ThemeNotifier with ChangeNotifier {
  int _colorIndex = 0;

  SharedPreferences _prefs;

  void checkTheme() async {
    _prefs = await SharedPreferences.getInstance();

    print(_prefs.getInt("colorTheme"));

    _colorIndex = 
    _prefs.getInt("colorTheme") == null
        ? 0
        : _prefs.getInt("colorTheme");

    notifyListeners();
  }

  ThemeNotifier() {
    checkTheme();
  }

  ThemeData get theme => themeMakerLight(
    appColors[_colorIndex].color
    );

  ThemeColor get selectedThemeColor => appColors[_colorIndex];

  void toggleTheme(index) async {
    _colorIndex = index;

    await _prefs.setInt("colorTheme", _colorIndex);

    notifyListeners();
  }
}
