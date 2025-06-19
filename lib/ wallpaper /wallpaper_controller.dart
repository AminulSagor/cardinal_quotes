import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../combine_service/save_service.dart';

import 'wallpaper_service.dart';

class WallpaperController extends GetxController {
  var wallpapers = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  bool hasInitialized = false;
  final saveService = CombineSaveService();
  static const platform = MethodChannel('com.cardinal.wallpaper');


  Future<void> loadWallpapers(String category) async {
    isLoading.value = true;
    final fetched = await WallpaperService.fetchWallpapers(category);
    wallpapers.value = fetched;
    isLoading.value = false;
  }

  Future<void> saveWallpaper(int id) async {
    final success = await saveService.saveItem('visual', id);
    if (success) {
      Get.snackbar('Saved', 'Wallpaper saved successfully');
    } else {
      Get.snackbar('Error', 'Failed to save wallpaper');

    }
  }



  Future<void> setWallpaper(String imageUrl, String target) async {
    try {
      final result = await platform.invokeMethod('setWallpaper', {
        'url': imageUrl,
        'target': target, // "home", "lock", or "both"
      });
      Get.snackbar('Wallpaper', result ?? 'Wallpaper set');
    } catch (e) {
      Get.snackbar('Error', 'Failed: $e');
    }
  }



  Future<void> downloadWallpaper(String imageUrl) async {
    try {
      final status = await Permission.photos.request(); // For Android 13+ use Permission.photos
      if (!status.isGranted) {
        Get.snackbar('Permission', 'Storage permission denied');
        return;
      }

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List fileData = response.bodyBytes;

        final result = await ImageGallerySaverPlus.saveImage(
          fileData,
          quality: 100,
          name: 'wallpaper_${DateTime.now().millisecondsSinceEpoch}',
        );


        if (result['isSuccess'] == true || result['isSuccess'] == 'true') {
          Get.snackbar('Download Complete', '✅ Image saved to Gallery');
        } else {
          Get.snackbar('Error', '❌ Failed to save image');
        }
      } else {
        Get.snackbar('Error', '❌ Failed to fetch image');
      }
    } catch (e) {
      Get.snackbar('Error', '❌ Download error: $e');
    }
  }


}
