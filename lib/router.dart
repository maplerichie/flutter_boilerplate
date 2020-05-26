import 'package:flutter/material.dart';
import 'screens/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  dynamic args = settings.arguments;
  print('Args: $args');
  print('Route: ${settings.name}');
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => Root());
    default:
      return MaterialPageRoute(builder: (context) => Navi404());
  }
}
