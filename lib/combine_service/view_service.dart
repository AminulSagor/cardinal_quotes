import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ViewService {
  final Dio _dio = Dio();
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<void> increaseAudioView(int audioId) async {
    final url = '$baseUrl/users/view/audio/$audioId';
    try {
      final response = await _dio.put(url);
      print("👁️ View increased: ${response.data}");
    } catch (e) {
      print("❌ Error increasing view: $e");
    }
  }

  Future<void> increaseQuoteView(int quoteId) async {
    final url = '$baseUrl/users/view/quote/$quoteId';
    try {
      final response = await _dio.put(url);

      print("👁️ Quote view increased: ${response.data}");
    } catch (e) {
      print("❌ Error increasing quote view: $e");
    }
  }

  Future<void> increaseVisualView(int visualId) async {
    final url = '$baseUrl/users/view/visual/$visualId';
    try {
      final response = await _dio.put(url);
      print("👁️ Visual view increased: ${response.data}");
    } catch (e) {
      print("❌ Error increasing visual view: $e");
    }
  }


}
