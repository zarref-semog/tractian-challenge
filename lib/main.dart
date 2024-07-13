import 'package:flutter/material.dart';
import 'package:tractian_challenge/router_generator.dart';
import 'package:tractian_challenge/utils/build_tree.dart';
import 'package:tractian_challenge/utils/load_data.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Tractian",
    home: Home(data: buildTree(await loadData())),
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
