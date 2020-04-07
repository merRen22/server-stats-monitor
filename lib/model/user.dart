import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  bool isInitialValue;
  FirebaseUser data;

  CurrentUser._(this.data, this.isInitialValue);

  //factory to call the creation of a new user on first login
  static var initial = CurrentUser._(null, true);

  //factory to call the creation of a new user on first login
  factory CurrentUser.create(FirebaseUser data) => CurrentUser._(data,false);

  //facotry to set CurrentUser to initial state on log out
  factory CurrentUser.update() => initial;
}
