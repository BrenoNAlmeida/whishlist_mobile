import 'package:wishlist/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WishListService extends ApiService {
  WishListService() : super(service: 'list/');

  Future<dynamic> _handleResponse(http.Response response) async {
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception('Erro ao processar a requisição: ${response.statusCode}');
    }
  }

  Future<dynamic> getWishListFromUser(int id) async {
    final response = await http.get(
      Uri.parse(baseUrl + service + 'get_list_user_id/$id/'),
      headers: {'Content-Type': 'application/json'},
    );

    return await _handleResponse(response);
  }
}
