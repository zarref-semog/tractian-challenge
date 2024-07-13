import 'package:tractian_challenge/api/api_service.dart';

Future<Map<String, dynamic>> loadData() async {
  final Map<String, dynamic> data = {};

  final List<dynamic> companies = await ApiService.getCompanies();

  for (var comp in companies) {
    List<dynamic> assets = await ApiService.getAssets(comp['id']);

    List<dynamic> locations = await ApiService.getLocations(comp['id']);

    data[comp['id']] = {'assets': assets, 'locations': locations};
  }

  data['companies'] = companies;

  return data;
}
