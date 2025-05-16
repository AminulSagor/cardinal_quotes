import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<String> wallpapers = <String>[].obs;
  final RxList<String> quotes = <String>[].obs;
  final RxList<String> memorialCards = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() {
    wallpapers.assignAll([
      'assets/quote.png',
      'assets/quote.png',
      'assets/quote.png',
    ]);

    quotes.assignAll([
      'assets/quote.png',
      'assets/quote.png',
      'assets/quote.png',
    ]);

    memorialCards.assignAll([
      'assets/quote.png',
      'assets/quote.png',
      'assets/quote.png',
    ]);
  }
}
