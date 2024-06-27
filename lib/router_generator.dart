import 'package:flutter/material.dart';
import 'package:tractian_challenge/screens/asset_tree.dart';

import 'screens/home.dart';
import 'screens/page_not_found.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        if (args is List<Map<String, dynamic>>) {
          return MaterialPageRoute(builder: (_) => Home(data: args));
        } else {
          return MaterialPageRoute(builder: (_) => Home(data: []));
        }
      case "/asset-tree":
        if (args is List<Map<String, dynamic>>) {
          return MaterialPageRoute(builder: (_) => AssetTree(data: args));
        } else {
          return MaterialPageRoute(builder: (_) => AssetTree(data: []));
        }
      default:
        return MaterialPageRoute(builder: (_) => const PageNotFound());
    }
  }
}
