import 'package:flutter/foundation.dart';

/// A wrapper of [FirebaseUser] provides infomation to distinguish the initial value.
@immutable
class CurrentUser extends ChangeNotifier {
  bool _isSunny = true;

  CurrentUser() {
    _isSunny = true;
  }

  bool get sunny => _isSunny;

  void toggleSunny() {
    _isSunny = !_isSunny;
    notifyListeners();
  }
}
