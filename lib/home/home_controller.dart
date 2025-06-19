import 'package:get/get.dart';
import 'home_service.dart';

class HomeController extends GetxController {
  final RxList<String> wallpapers = <String>[].obs;
  final RxList<Map<String, dynamic>> quotes = <Map<String, dynamic>>[].obs;
  final RxList<String> memorialCards = <String>[].obs;
  final RxList<Map<String, dynamic>> announcements = <Map<String, dynamic>>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadInitialData();
    loadAnnouncements();
  }

  void loadInitialData() async {
    final response = await HomeService.getFeaturedItems();
    final visualList = response['visualList'] ?? [];
    final quoteList = response['quoteList'] ?? [];

    wallpapers.assignAll(
      visualList.where((e) => e['category'] == 'wallpaper').map<String>((e) => e['image_path']).toList(),
    );

    memorialCards.assignAll(
      visualList.where((e) => e['category'] == 'memorial_card').map<String>((e) => e['image_path']).toList(),
    );




    quotes.assignAll(quoteList);

  }

  void loadAnnouncements() async {
    final data = await HomeService.getVisualsByCategory('announcement');
    print('📢 Announcements: $data');
    announcements.assignAll(data);
  }



}
