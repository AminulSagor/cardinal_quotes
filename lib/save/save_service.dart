import 'package:dio/dio.dart';

class SaveService {
  final dio = Dio();

  Future<List<dynamic>> fetchAudios(String keyword) async {
    final url = 'https://cardinaldailyquotes.com/api/users/keywords/$keyword?audio_page=1&audio_limit=4';
    final response = await dio.get(url);
    print('RESPONSE: ${response.data}');
    return response.data['data']['audios'] ?? [];
  }

  Future<List<Map<String, dynamic>>> fetchQuotes(String keyword) async {
    final url = 'https://cardinaldailyquotes.com/api/users/keywords/$keyword?quote_page=1&quote_limit=1';
    final response = await dio.get(url);
    print('📝 QUOTE RESPONSE: ${response.data}');
    final quotes = response.data['data']['quotes'] ?? [];
    return List<Map<String, dynamic>>.from(quotes.map((item) {
      final isText = item['is_text'] == 1;
      return {
        'type': isText ? 'text' : 'image',
        'text': isText ? item['quote'] : null,
        'background': isText ? null : item['quote'],
        'tags': item['keywords'] ?? [],
        'views': item['view_count'] ?? 0,
        'id': item['id'],
      };
    }));
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchVisuals(String keyword) async {
    final url = 'https://cardinaldailyquotes.com/api/users/keywords/$keyword?visual_page=1&visual_limit=10';
    final response = await dio.get(url);
    print('🖼️ VISUAL RESPONSE: ${response.data}');
    final visuals = response.data['data']['visuals'] ?? [];

    final wallpapers = visuals.where((v) => v['category'] == 'wallpaper').map<Map<String, dynamic>>((item) => {
      'type': 'visual',
      'background': item['image_path'],
      'tags': item['keywords'] ?? [],
      'views': item['view_count'] ?? 0,
      'id': item['id'],
    }).toList();

    final memorials = visuals.where((v) => v['category'] == 'memorial_card').map<Map<String, dynamic>>((item) => {
      'type': 'visual',
      'background': item['image_path'],
      'tags': item['keywords'] ?? [],
      'views': item['view_count'] ?? 0,
      'id': item['id'],
    }).toList();

    return {
      'wallpapers': wallpapers,
      'memorials': memorials,
    };
  }

  Future<Map<String, List<Map<String, dynamic>>>> fetchSavedPosts(String token) async {
    final url = 'https://cardinaldailyquotes.com/api/users/saved';

    final response = await dio.get(
      url,
      options: Options(headers: {
        'authorization': 'Bearer $token',
      }),
    );

    final data = response.data['data'];

    // Format audios (already in desired format)
    final audios = List<Map<String, dynamic>>.from(data['audios'] ?? []);

    // Format quotes like in fetchQuotes()
    final quotes = List<Map<String, dynamic>>.from((data['quotes'] ?? []).map((item) {
      final isText = item['is_text'] == 1;
      return {
        'type': isText ? 'text' : 'image',
        'text': isText ? item['quote'] : null,
        'background': isText ? null : item['quote'],
        'tags': item['keywords'] ?? [],
        'views': item['view_count'] ?? 0,
        'id': item['id'],
      };
    }));

    // Format visuals (wallpapers and memorials) like in fetchVisuals()
    final visuals = List<Map<String, dynamic>>.from(data['visuals'] ?? []);

    final wallpapers = visuals.where((v) => v['category'] == 'wallpaper').map<Map<String, dynamic>>((item) => {
      'type': 'visual',
      'background': item['image_path'],
      'tags': item['keywords'] ?? [],
      'views': item['view_count'] ?? 0,
      'id': item['id'],
    }).toList();

    final memorials = visuals.where((v) => v['category'] == 'memorial_card').map<Map<String, dynamic>>((item) => {
      'type': 'visual',
      'background': item['image_path'],
      'tags': item['keywords'] ?? [],
      'views': item['view_count'] ?? 0,
      'id': item['id'],
    }).toList();

    return {
      'audios': audios,
      'quotes': quotes,
      'wallpapers': wallpapers,
      'memorials': memorials,
    };
  }


}
