import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../storage/token_storage.dart';

class CombineSaveService {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<bool> saveItem(String itemType, int id) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('$baseUrl/users/save/$itemType/$id');
    print('📤 Sending POST request to: $url');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('📥 Response: ${response.statusCode} ${response.body}');
      final data = json.decode(response.body);
      return data['status'] == 'success';
    } catch (e) {
      print('❌ Save error: $e');
      return false;
    }
  }
}
