import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String user = "/user";
  static String discord = "/discord";
  static String newConfiguration = "/configuration/new";
  static String configurationEdition = "/configuration:id";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (ctx, params) =>
      Scaffold(
        appBar: AppBar(),
        body: Center(child: Text("Route not available, go to previous screen")),
      ),
    );
    router.define(root, handler: rootHandler);
    router.define(user, handler: userHandler);
    /*
    router.define(demoSimpleFixedTrans,
        handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
        */
  }
}
