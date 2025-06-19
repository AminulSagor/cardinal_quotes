import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeService {
  static const String _baseUrl = 'https://cardinaldailyquotes.com/api';

  static Future<Map<String, List<Map<String, dynamic>>>> getFeaturedItems() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/featureds'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final visualList = data['data']['visualList'] as List;
          final quoteList = data['data']['quoteList'] as List;

          return {
            'visualList': visualList.cast<Map<String, dynamic>>(),
            'quoteList': quoteList.cast<Map<String, dynamic>>(),
          };
        }
      }
      return {'visualList': [], 'quoteList': []};
    } catch (e) {
      print('❌ HomeService Error: $e');
      return {'visualList': [], 'quoteList': []};
    }
  }

  static Future<List<Map<String, dynamic>>> getVisualsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/visuals/$category'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final items = data['data'];
          if (items is List) {
            return List<Map<String, dynamic>>.from(items);
          } else if (items is Map && items.containsKey('items')) {
            return List<Map<String, dynamic>>.from(items['items']);
          }
        }
      }
      return [];
    } catch (e) {
      print('❌ getVisualsByCategory Error: $e');
      return [];
    }
  }





}
