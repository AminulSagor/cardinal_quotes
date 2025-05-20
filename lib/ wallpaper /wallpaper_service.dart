
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WallpaperService {
  static final String _baseUrl = dotenv.env['BASE_URL']!;

  static Future<List<Map<String, dynamic>>> fetchWallpapers(String category) async {
    final url = Uri.parse('$_baseUrl/visuals/$category');
    print("🔗 Wallpaper API Request: $url");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data['status'] == 'success') {
          return (data['data'] as List).map<Map<String, dynamic>>((item) {
            return {
              'background': item['image_path'],
              'tags': item['keywords'] ?? [],
              'views': item['view_count'] ?? 0,
            };
          }).toList();
        }
      }
      throw Exception('❌ Failed to load wallpapers');
    } catch (e) {
      print('🛑 WallpaperService error: $e');
      return [];
    }
  }
}
