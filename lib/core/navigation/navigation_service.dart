import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> push<T extends Object?>(Route<T> route) {
    return navigator.push<T>(route);
  }

  static void pop<T extends Object?>([T? result]) {
    navigator.pop<T>(result);
  }
}
