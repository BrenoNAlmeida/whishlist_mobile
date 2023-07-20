import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wishlist/services/api_service.dart';

class WishService extends ApiService {
  WishService() : super(service: 'wish/');

  Future<dynamic> _handleResponse(http.Response response) async {
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception('Erro ao processar a requisição: ${response.statusCode}');
    }
  }

  Future<dynamic> getWishesFromWishlist(int wishlistId) async {
    final response = await http.get(Uri.parse(baseUrl + service + 'get_wishs_list_id/' + wishlistId.toString() + '/'));

    return await _handleResponse(response);
  }
}
