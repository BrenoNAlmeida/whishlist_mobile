import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://31.220.58.21:8000/api/';
  final String service;

  ApiService({this.service = ''});

  Future<dynamic> _handleResponse(http.Response response) async {
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return responseBody;
    } else {
      throw Exception('Erro ao processar a requisição: ${response.statusCode}');
    }
  }

  Future<dynamic> getAll() async {
    final response = await http.get(Uri.parse(baseUrl + service));

    return await _handleResponse(response);
  }

  Future<dynamic> get(int id) async {
    final response =
        await http.get(Uri.parse(baseUrl + service + id.toString()));

    return await _handleResponse(response);
  }

  Future<dynamic> post(data) async {
    final response = await http.post(
      Uri.parse(baseUrl + service),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return await _handleResponse(response);
  }

  Future<dynamic> put(int id, data) async {
    final response = await http.put(
      Uri.parse(baseUrl + service + id.toString()),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return await _handleResponse(response);
  }

  Future<dynamic> patch(int id, data) async {
    final response = await http.patch(
      Uri.parse(baseUrl + service + id.toString()),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return await _handleResponse(response);
  }

  Future<dynamic> delete(int id) async {
    final response =
        await http.delete(Uri.parse(baseUrl + service + id.toString()));

    return await _handleResponse(response);
  }
}
