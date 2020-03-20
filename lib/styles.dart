import 'package:flutter/material.dart';

class FontWeights {
  FontWeights._();

  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const normal = FontWeight.normal;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.bold;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;
}

const kBottomBarSize = 56.0;
const kIconTintLight = Color(0xFF5F6368);
const kIconTintCheckedLight = Color(0xFF202124);
const kLabelColorLight = Color(0xFF202124);
const kCheckedLabelBackgroudLight = Color(0x337E39FB);
const kHintTextColorLight = Color(0xFF61656A);
const kNoteTitleColorLight = Color(0xFF202124);
const kNoteTextColorLight = Color(0x99000000);
const kNoteDetailTextColorLight = Color(0xC2000000);
const kErrorColorLight = Color(0xFFD43131);
const kWarnColorLight = Color(0xFFFD9726);
const kBorderColorLight = Color(0xFFDADCE0);
const kColorPickerBorderColor = Color(0x21000000);
const kBottomAppBarColorLight = Color(0xF2FFFFFF);

const _kPurplePrimaryValue = 0xFF7E39FB;
const kAccentColorLight = MaterialColor(
  _kPurplePrimaryValue,
  <int, Color>{
    900: Color(0xFF0000c9),
    800: Color(0xFF3f00df),
    700: Color(0xFF2500d7),
    600: Color(0xFF6200ee),
    500: Color(_kPurplePrimaryValue),
    400: Color(0xFF5400e8),
    300: Color(0xFF995dff),
    200: Color(0xFFe3b8ff),
    100: Color(0xFFdab2ff),
    50: Color(0xFFfbd5ff),
  },
);
