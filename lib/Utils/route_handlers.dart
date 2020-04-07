import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:server_sync/screens.dart' show LoginScreen, HomeScreen, SessionSetUp, UserDetailsScreen, AboutScreen;
import 'package:server_sync/models.dart' show CurrentUser;

var rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    final user = Provider.of<CurrentUser>(context);
    
    return user.isInitialValue
          ? SessionSetUp()
          : user.data == null ? LoginScreen() : HomeScreen();
});

var userHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return UserDetailsScreen();
});

var aboutHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AboutScreen();
});
