import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://fake-api.tractian.com';

  static Future<List<dynamic>> getCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/companies'));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  static Future<List<dynamic>> getLocations(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/companies/$id/locations'));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  static Future<List<dynamic>> getAssets(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/companies/$id/assets'));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }
}
