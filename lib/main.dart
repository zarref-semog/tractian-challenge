import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tractian_challenge/router_generator.dart';
import 'package:tractian_challenge/utils/build_tree.dart';
import 'dart:convert';
import 'api/api_service.dart';
import 'screens/home.dart';

Future<Map<String, dynamic>> loadData() async {
  final apiService = ApiService('https://fake-api.tractian.com');
  final companies = apiService.getCompanies('/companies');
  print(companies);
  return {};
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Tractian",
    home: Home(data: BuildTree.build(await loadData())),
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
