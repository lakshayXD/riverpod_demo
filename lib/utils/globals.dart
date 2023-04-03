import 'package:flutter/material.dart';

class Globals {
  Globals._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static BuildContext get context => navigatorKey.currentContext!;
}
