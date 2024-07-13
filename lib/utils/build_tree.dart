import '../models/asset.dart';
import '../models/company.dart';
import '../models/component.dart';
import '../models/location.dart';

List<Map<String, dynamic>> buildTree(Map<String, dynamic> data) {
  final companies = <String, Company>{};
  final locations = <String, Location>{};
  final assets = <String, Asset>{};
  final components = <String, Component>{};

  if (data == {}) return [];

  // Create company objects
  for (var company in data["companies"]) {
    companies[company["id"]] =
        Company(id: company["id"], name: company["name"], children: []);
  }

  // Create location objects
  data.forEach((companyId, value) {
    if (companyId != "companies") {
      for (var loc in value["locations"]) {
        locations[loc["id"]] = Location(
            id: loc["id"],
            name: loc["name"],
            parentId: loc["parentId"] ?? "",
            children: []);
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
              parentId: asset["parentId"] ?? "",
              locationId: asset["locationId"] ?? "",
              children: []);
        } else {
          assets[asset["id"]] = Asset(
              id: asset["id"],
              name: asset["name"],
              status: asset["status"],
              parentId: asset["parentId"] ?? "",
              locationId: asset["locationId"] ?? "",
              children: []);
        }
      }
    }
  });

  // Build relationships
  data.forEach((companyId, value) {
    if (companyId != "companies") {
      for (var loc in value["locations"]) {
        if (loc["parentId"] != null && loc["parentId"].isNotEmpty) {
          locations[loc["parentId"]]?.children.add(locations[loc["id"]]);
        } else {
          companies[companyId]?.children.add(locations[loc["id"]]);
        }
      }
      for (var asset in value["assets"]) {
        if (asset.containsKey("sensorId") && asset["sensorId"] != null) {
          if (asset["locationId"] != null && asset["locationId"].isNotEmpty) {
            locations[asset["locationId"]]
                ?.children
                .add(components[asset["id"]]);
          } else if (asset["parentId"] != null &&
              asset["parentId"].isNotEmpty) {
            assets[asset["parentId"]]?.children.add(components[asset["id"]]);
          } else {
            companies[companyId]?.children.add(components[asset["id"]]);
          }
        } else {
          if (asset["locationId"] != null && asset["locationId"].isNotEmpty) {
            locations[asset["locationId"]]?.children.add(assets[asset["id"]]);
          } else if (asset["parentId"] != null &&
              asset["parentId"].isNotEmpty) {
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
      "id": company.id,
      "name": company.name,
      "children": serializeChildren(company.children),
    });
  });
  print(result);
  return result;
}

List<Map<String, dynamic>> serializeChildren(List<dynamic> children) {
  List<Map<String, dynamic>> result = [];
  for (var child in children) {
    if (child is Location) {
      result.add({
        "id": child.id,
        "name": child.name,
        "icon": child.icon,
        "parentId": child.parentId,
        "children": serializeChildren(child.children),
      });
    } else if (child is Asset) {
      result.add({
        "id": child.id,
        "name": child.name,
        "status": child.status,
        "icon": child.icon,
        "parentId": child.parentId,
        "locationId": child.locationId,
        "children": serializeChildren(child.children),
      });
    } else if (child is Component) {
      result.add({
        "id": child.id,
        "name": child.name,
        "sensorId": child.sensorId,
        "sensorType": child.sensorType,
        "status": child.status,
        "gatewayId": child.gatewayId,
        "icon": child.icon,
        "parentId": child.parentId,
        "locationId": child.locationId,
        "children": serializeChildren(child.children),
      });
    }
  }
  return result;
}
