import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AudioService {
  final Dio _dio = Dio();
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<Map<String, dynamic>>> fetchAudiosByCategory(String category) async {
    final url = '$baseUrl/audios/$category';
    print("🔍 API Call → $url");

    try {
      final response = await _dio.get(url);
      print("📦 Full Response: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        print("⚠️ API returned error status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Error fetching audios: $e");
      return [];
    }
  }
}
