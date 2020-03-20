import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:server_sync/models.dart';
import 'package:server_sync/styles.dart';

class LightManager extends StatefulWidget {
  @override
  _LightManagerState createState() => _LightManagerState();
}

class _LightManagerState extends State<LightManager> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeNotifier>(context);

    return FloatingActionButton(
        key: UniqueKey(),
        backgroundColor:
            themeProvider.sunny ? kAccentColorLight : Color(0xff2C2F33),
        child: FaIcon(
            themeProvider.sunny ? FontAwesomeIcons.sun : FontAwesomeIcons.moon),
        onPressed: () => themeProvider.toggleSunny());
  }
}
