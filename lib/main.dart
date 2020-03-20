import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart' show CurrentUser;
import 'screens.dart' show HomeScreen, LoginScreen, NoteEditor, SettingsScreen;
import 'styles.dart';

void main() => runApp(SyncApp());

final controller = StreamController<CurrentUser>();

class SyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamProvider.value(
        //Discord data should ve sent here
        value: controller.stream,
        initialData: CurrentUser.initial,
        child: Consumer<CurrentUser>(
          builder: (context, user, _) => MaterialApp(
              title: 'MC - Sync',
              debugShowCheckedModeBanner: false,
              theme: Theme.of(context).copyWith(
                brightness: Brightness.light,
                primaryColor: Colors.white,
                accentColor: kAccentColorLight,
                appBarTheme: AppBarTheme.of(context).copyWith(
                  elevation: 0,
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(
                    color: kIconTintLight,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomAppBarColor: kBottomAppBarColorLight,
                primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                      title: const TextStyle(
                        color: kIconTintLight,
                      ),
                    ),
              ),
              home: LoginScreen(),
              routes: {
                '/settings': (_) => SettingsScreen(),
              }),
        ),
      );
}
