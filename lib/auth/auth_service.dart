import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": "Failed to register. (${response.statusCode})"
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "An error occurred: $e"
      };
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          "status": "error",
          "message": "Login failed (${response.statusCode})"
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "An error occurred: $e"
      };
    }
  }

}
