import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart' show CurrentUser, ThemeNotifier;
import 'screens.dart' show HomeScreen, LoginScreen, NoteEditor, SettingsScreen;
import 'styles.dart';

void main() => runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (ctxProvider) => ThemeNotifier(), child: SyncApp()));

class SyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
        title: 'MC - Sync',
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.theme,
        home: LoginScreen(),
        routes: {
          '/settings': (_) => SettingsScreen(),
        });
  }
}
