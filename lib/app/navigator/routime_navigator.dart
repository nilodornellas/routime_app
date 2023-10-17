import 'package:flutter/material.dart';

class RoutimeNavigator {
  RoutimeNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}
