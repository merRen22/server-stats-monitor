import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:server_sync/model/themeNotifier.dart';


class ActionFlatButton extends StatefulWidget {
  final String label;

  ActionFlatButton({Key key, this.label}) : super(key: key);

  @override
  _ActionFlatButtonState createState() => _ActionFlatButtonState();
}

class _ActionFlatButtonState extends State<ActionFlatButton> {
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text(
        widget.label,
      ),
    );
  }
}

/*



class ActionFlatButton extends StatelessWidget {
  final String label;

  const ActionFlatButton({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(Theme.of(context).buttonColor);

    var themeProvider = Provider.of<ThemeNotifier>(context);
    
    final color = Theme.of(context).buttonColor;    

    return FlatButton(
      color: color,
      shape: StadiumBorder(),
      onPressed: () => {},
      child: Text(
        this.label,
      ),
    );
  }
}


*/