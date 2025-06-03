import 'dart:convert';
import 'package:http/http.dart' as http;

class NoteService {
  final String baseUrl = 'https://cardinaldailyquotes.com/api';

  Future<bool> createNote({
    required String token,
    required String note,
    String? title,
  }) async {
    final uri = Uri.parse('$baseUrl/users/notes/upload');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'note': note,
          if (title != null && title.isNotEmpty) 'title': title,
        }),
      );

      final json = jsonDecode(response.body);
      return json['status'] == 'success';
    } catch (e) {
      print('Error creating note: $e');
      return false;
    }
  }

  Future<bool> updateNote({
    required String token,
    required int noteId,
    required String note,
    String? title,
  }) async {
    final uri = Uri.parse('https://cardinaldailyquotes.com/api/users/notes/update/$noteId');

    try {
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'note': note,
          if (title != null && title.isNotEmpty) 'title': title,
        }),
      );

      final json = jsonDecode(response.body);
      return json['status'] == 'success';
    } catch (e) {
      print('Error updating note: $e');
      return false;
    }
  }

}
