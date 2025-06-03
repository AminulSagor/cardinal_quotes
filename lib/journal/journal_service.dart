import 'dart:convert';
import 'package:http/http.dart' as http;

class JournalService {
  final String baseUrl = 'https://cardinaldailyquotes.com/api';

  Future<List<Map<String, dynamic>>> fetchJournals(String token) async {
    final uri = Uri.parse('$baseUrl/users/notes');

    try {
      final response = await http.get(
        uri,
        headers: {
          'authorization': 'Bearer $token',
        },
      );
      print('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['status'] == 'success') {
          return List<Map<String, dynamic>>.from(decoded['data']);
        }
      }
    } catch (e) {
      print('Error: $e');
    }

    return [];
  }
}
