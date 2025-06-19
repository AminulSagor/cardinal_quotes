import 'package:get/get.dart';

import '../combine_service/view_service.dart';


class QuoteFullController extends GetxController {
  var type = ''.obs;
  var background = ''.obs;
  var text = ''.obs;
  final viewService = ViewService();

  void setQuote(Map<String, dynamic> quote) {
    type.value = quote['type'] ?? '';
    background.value = quote['background'] ?? '';
    text.value = quote['text'] ?? '';

    if (quote['id'] != null) {
      increaseView(quote['id']);
    }
  }

  void increaseView(int id) async {
    await viewService.increaseQuoteView(id);
  }
}
