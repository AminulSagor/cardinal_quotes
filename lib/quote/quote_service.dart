import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class QuoteService {
  static final String _baseUrl = dotenv.env['BASE_URL']!;

  static Future<List<Map<String, dynamic>>> fetchQuotesByCategory(String category) async {
    final isVisual = category.contains('wallpaper') || category.contains('memorial_card');
    final endpoint = isVisual ? 'visuals' : 'quotes';
    final url = Uri.parse('$_baseUrl/$endpoint/$category');

    print("🔗 API Request: $url");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data['status'] == 'success') {
          return (data['data'] as List).map<Map<String, dynamic>>((item) {
            if (isVisual) {
              return {
                'type': 'visual',
                'background': item['image_path'],
                'tags': item['keywords'] ?? [],
                'views': item['view_count'] ?? 0,
              };
            } else {
              final isText = item['is_text'] == 1;
              return {
                'type': isText ? 'text' : 'image',
                'text': isText ? item['quote'] : null,
                'background': isText ? null : item['quote'],
                'tags': item['keywords'] ?? [],
                'views': item['view_count'] ?? 0,
              };
            }
          }).toList();
        }
      }

      throw Exception('❌ Failed to load data');
    } catch (e) {
      print('🛑 QuoteService error: $e');
      return [];
    }
  }
}
