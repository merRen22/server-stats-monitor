import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart' show ThemeNotifier, CurrentUser;
import 'utils.dart' show Routes, Application;

void main() => runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (ctxProvider) => ThemeNotifier(),
        child: SyncApp(),
      ),
    );

class SyncApp extends StatelessWidget {
  SyncApp() {
    final router = Router();

    Routes.configureRoutes(router);

    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return StreamProvider.value(
      initialData: CurrentUser.initial,
      value: FirebaseAuth.instance.onAuthStateChanged
          .map((user) => CurrentUser.create(user)),
      child: appValues(themeNotifier),
    );
  }

  Widget appValues(themeNotifier) {
    final app = MaterialApp(
      title: 'Server-Sync',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.theme,
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}
