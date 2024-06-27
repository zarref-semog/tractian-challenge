import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tractian_challenge/router_generator.dart';
import 'dart:convert';
import 'models/asset.dart';
import 'models/company.dart';
import 'models/component.dart';
import 'models/location.dart';
import 'screens/home.dart';
import 'screens/asset_tree.dart';

Future<Map<String, dynamic>> loadData() async {
  try {
    final String jsonString =
        await rootBundle.loadString('lib/api/api_data.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  } catch (e) {
    return {'Error': e.toString()};
  }
}

List<Map<String, dynamic>> buildTree(Map<String, dynamic> data) {
  final companies = <String, Company>{};
  final locations = <String, Location>{};
  final assets = <String, Asset>{};
  final components = <String, Component>{};

  // Create company objects
  for (var company in data["companies"]) {
    companies[company["id"]] =
        Company(id: company["id"], name: company["name"]);
  }

  // Create location objects
  data.forEach((companyId, value) {
    if (companyId != "companies") {
      for (var loc in value["locations"]) {
        locations[loc["id"]] = Location(id: loc["id"], name: loc["name"]);
      }
    }
  });

  // Create asset and component objects
  data.forEach((companyId, value) {
    if (companyId != "companies") {
      for (var asset in value["assets"]) {
        if (asset.containsKey("sensorId") && asset["sensorId"] != null) {
          components[asset["id"]] = Component(
            id: asset["id"],
            name: asset["name"],
            sensorId: asset["sensorId"],
            sensorType: asset["sensorType"],
            status: asset["status"],
            gatewayId: asset["gatewayId"],
          );
        } else {
          assets[asset["id"]] = Asset(
            id: asset["id"],
            name: asset["name"],
            status: asset["status"],
          );
        }
      }
    }
  });

  // Build relationships
  data.forEach((companyId, value) {
    if (companyId != "companies") {
      for (var loc in value["locations"]) {
        if (loc["parentId"] != null) {
          locations[loc["parentId"]]?.children.add(locations[loc["id"]]);
        } else {
          companies[companyId]?.children.add(locations[loc["id"]]);
        }
      }
      for (var asset in value["assets"]) {
        if (asset.containsKey("sensorId") && asset["sensorId"] != null) {
          if (asset["locationId"] != null) {
            locations[asset["locationId"]]
                ?.children
                .add(components[asset["id"]]);
          } else if (asset["parentId"] != null) {
            assets[asset["parentId"]]?.children.add(components[asset["id"]]);
          } else {
            companies[companyId]?.children.add(components[asset["id"]]);
          }
        } else {
          if (asset["locationId"] != null) {
            locations[asset["locationId"]]?.children.add(assets[asset["id"]]);
          } else if (asset["parentId"] != null) {
            assets[asset["parentId"]]?.children.add(assets[asset["id"]]);
          } else {
            companies[companyId]?.children.add(assets[asset["id"]]);
          }
        }
      }
    }
  });

  // Convert to required JSON format
  List<Map<String, dynamic>> result = [];
  companies.forEach((companyId, company) {
    result.add({
      "name": company.name,
      "children": serializeChildren(company.children),
    });
  });

  return result;
}

List<Map<String, dynamic>> serializeChildren(List<dynamic> children) {
  List<Map<String, dynamic>> result = [];
  for (var child in children) {
    if (child is Location) {
      result.add({
        "name": child.name,
        "icon": child.icon,
        "children": serializeChildren(child.children),
      });
    } else if (child is Asset) {
      result.add({
        "name": child.name,
        "status": child.status,
        "icon": child.icon,
        "children": serializeChildren(child.children),
      });
    } else if (child is Component) {
      result.add({
        "name": child.name,
        "sensorId": child.sensorId,
        "sensorType": child.sensorType,
        "status": child.status,
        "gatewayId": child.gatewayId,
        "icon": child.icon,
        "children": serializeChildren(child.children),
      });
    }
  }
  return result;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Tractian",
    home: Home(data: buildTree(await loadData())),
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
