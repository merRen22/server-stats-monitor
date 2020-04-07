import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:server_sync/animations.dart' show AnimatedWave;
import 'package:server_sync/models.dart' show CurrentUser;
import 'package:server_sync/widgets.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({Key key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  bool _loadingData = false;

  Widget rowData(icon, label) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (icon != null) FaIcon(icon),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: icon == null
                    ? Theme.of(context).textTheme.headline4
                    : Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );

  Widget infoCard(content) => Row(
    mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: kIsWeb? 350 : MediaQuery.of(context).size.width * 2 / 3,
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 0, 16),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: content),
              ),
            ),
          ),
        ],
      );

  TextStyle dangerLabelStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  Widget dangerButton(icon, action, label) {
    double buttonWidth = 200;

    return RaisedButton(
      color: Colors.redAccent,
      onPressed: action,
      child: Container(
        width: buttonWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FaIcon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(label, style: dangerLabelStyle)
          ],
        ),
      ),
    );
  }

  final animatedWave = AnimatedWave(height: 60, speed: 1.5);

  Future<void> tryReauthenticateUser() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            key: Key("tryReauthenticateUser"),
            title: Text("Please reauthenticate your password"),
            content: Text(
                'In order to procede with account deletion,\nyou must log in.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('cancel')),
              FlatButton(
                  onPressed: () async {
                    final googleUser = await _googleSignIn.signIn();
                    final googleAuth = await googleUser.authentication;
                    final credential = GoogleAuthProvider.getCredential(
                      idToken: googleAuth.idToken,
                      accessToken: googleAuth.accessToken,
                    );
                    await _auth.signInWithCredential(credential);
                    await deleteUserData();       
                    await _firebaseUser.delete();
                    await Navigator.of(context).pop();
                  },
                  child: Text('next'))
            ],
          );
        });
  }

  Future deleteUserData() async {
    //delete all documents from user colection
      await Firestore.instance.collection('configurations-${_firebaseUser.uid}').getDocuments().then((docs) { 
        for( var doc in docs.documents){
          doc.reference.delete();
        }
        });
  }

  void deleteAccount() async {
    try {
      await deleteUserData();
      await _firebaseUser.delete();
    } catch (ex) {
      await tryReauthenticateUser();
    }

    await FirebaseAuth.instance.signOut();

    await Navigator.of(context).pop();
  }

  void logOut() async {

    await _googleSignIn.signOut();

    await FirebaseAuth.instance.signOut();

    await Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _firebaseUser = Provider.of<CurrentUser>(context).data;

    if(_firebaseUser == null){
      _loadingData = true;
    }
    
    final imageSize = kIsWeb?75: MediaQuery.of(context).size.width / 5;

    final cardWidth = kIsWeb? MediaQuery.of(context).size.width * 3/ 5: MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            _loadingData
                ? Center(child: CircularProgressIndicator())
                : Center(
                  child: Container(
        color: Colors.transparent,
                    width: cardWidth,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Card(
                                margin: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        _firebaseUser.photoUrl != null ? NetworkImage(_firebaseUser.photoUrl) : null,
                                    child:
                                        _firebaseUser.photoUrl == null ? const Icon(Icons.face) : null,
                                    radius: imageSize,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text("Your theme"),
                                    LightManager()
                                  ]
                                ),
                              )
                            ],
                          ),
                          infoCard(
                            [
                              rowData(null, "Your data"),
                              rowData(FontAwesomeIcons.userCircle,
                                  _firebaseUser.displayName),
                              rowData(FontAwesomeIcons.envelope, _firebaseUser.email)
                            ],
                          ),
                          Column(
                            children: [
                              dangerButton(FontAwesomeIcons.signOutAlt,
                                  () => logOut(), "log out"),
                              dangerButton(FontAwesomeIcons.ban,
                                  () => deleteAccount(), "delete account"),
                            ],
                          ),
                        ],
                      ),
                  ),
                ),
            onBottom(animatedWave)
          ],
        ),
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
