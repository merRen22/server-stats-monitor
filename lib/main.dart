import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart' show ThemeNotifier, CurrentUser;
import 'screens.dart' show LoginScreen, SettingsScreen, HomeScreen, SessionSetUp;

void main() => runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (ctxProvider) => ThemeNotifier(),
        child: SyncApp(),
      ),
    );

class SyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return StreamProvider.value(
      initialData: CurrentUser.initial,
      value: FirebaseAuth.instance.onAuthStateChanged
          .map((user) => CurrentUser.create(user)),
      child: Consumer<CurrentUser>(
        builder: (ctx, user, _) => appValues(themeNotifier, user),
      ),
    );
  }

  Widget appValues(themeNotifier, user) => MaterialApp(
      title: 'MC - Sync',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.theme,
      home: user.isInitialValue
          ? SessionSetUp()
          : user.data == null ? LoginScreen() : HomeScreen(),
      routes: {
        '/settings': (_) => SettingsScreen(),
      },
    );
}
