import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  final bool isInitialValue;
  final FirebaseUser data;

  const CurrentUser._(this.data, this.isInitialValue);

  //factory to call the creation of a new user on first login
  static const initial = CurrentUser._(null, true);

  //factory to call the creation of a new user on first login
  factory CurrentUser.create(FirebaseUser data) => CurrentUser._(data,false);
}
