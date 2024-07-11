import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

var companies = convert.jsonEncode(
    http.get(Uri.parse('https://fake-api.tractian.com/companies/')));

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<dynamic>> getCompanies(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<Map<String, dynamic>> getLocations(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<Map<String, dynamic>> getAssets(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }
}
