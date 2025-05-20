import 'package:get/get.dart';
import 'quote_service.dart';

class QuoteController extends GetxController {
  var quotes = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> loadQuotes(String category) async {
    isLoading.value = true;
    final fetched = await QuoteService.fetchQuotesByCategory(category);
    quotes.value = fetched;
    isLoading.value = false;
  }
}
