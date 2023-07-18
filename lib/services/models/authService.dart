import 'dart:convert';

import 'package:wishlist/services/api_service.dart';
import 'package:http/http.dart' as http;

class AuthService extends ApiService {
  AuthService() : super(service: 'auth/');

  Future<dynamic> _handleResponse(http.Response response) async {
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception('Erro ao processar a requisição: ${response.statusCode}');
    }
  }

  Future<dynamic> registerUser(data) async {
    final response = await http.post(
      Uri.parse(baseUrl + service + 'cadastro/'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return await _handleResponse(response);
  }

  Future<dynamic> login(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl + service + 'login/'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return await _handleResponse(response);
  }
}
