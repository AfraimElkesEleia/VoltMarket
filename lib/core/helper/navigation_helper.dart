import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  Future<dynamic> pushNamed(String route, {Object? arguments}) {
    return Navigator.of(this).pushNamed(route, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String route, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(route, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String route,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(route, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}
