import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../combine_service/save_service.dart';
import '../save/save_service.dart';
import 'quote_service.dart';

class QuoteController extends GetxController {
  var quotes = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final combineSaveService = CombineSaveService();
  final saveService = SaveService();

  Future<void> loadQuotes(String category) async {
    isLoading.value = true;

    List<Map<String, dynamic>> fetched;

    if (category.toLowerCase().contains('soul')) {
      // Use keyword-based API if "soul" is in category
      fetched = await saveService.fetchQuotes(category);
    } else {
      // Use regular category-based fetch
      fetched = await QuoteService.fetchQuotesByCategory(category);
    }

    quotes.value = fetched;
    isLoading.value = false;
  }

  Future<void> saveQuote(int id) async {
    final success = await combineSaveService.saveItem('quote', id);
    if (success) {
      Get.snackbar("✅ Saved", "Quote saved successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("⚠️ Failed", "Failed to save quote",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}
