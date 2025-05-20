
import 'package:get/get.dart';
import 'wallpaper_service.dart';

class WallpaperController extends GetxController {
  var wallpapers = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> loadWallpapers(String category) async {
    isLoading.value = true;
    final fetched = await WallpaperService.fetchWallpapers(category);
    wallpapers.value = fetched;
    isLoading.value = false;
  }
}
