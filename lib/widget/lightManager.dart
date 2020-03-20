import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:server_sync/model/user.dart';

import 'package:server_sync/styles.dart';

class LightManager extends StatefulWidget {
  @override
  _LightManagerState createState() => _LightManagerState();
}

class _LightManagerState extends State<LightManager> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<CurrentUser>(context);

    return FloatingActionButton(
        key: UniqueKey(),
        backgroundColor:
            userProvider.sunny ? kAccentColorLight : Color(0xff2C2F33),
        child: FaIcon(
            userProvider.sunny ? FontAwesomeIcons.sun : FontAwesomeIcons.moon),
        onPressed: () => userProvider.toggleSunny());
  }
}
