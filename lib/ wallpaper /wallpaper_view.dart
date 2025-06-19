import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../ful_screen/wallpaper_full_view.dart';
import '../widgets/wallpaper_card_widget.dart';
import 'wallpaper_controller.dart';
import '../widgets/bottom_nav.dart';

class WallpaperView extends StatelessWidget {
  final String category;


  final controller = Get.put(WallpaperController());

  WallpaperView({super.key, required this.category}) {
    controller.loadWallpapers(category);
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.wallpapers.isEmpty) {
            return const Center(
              child: Text(
                'No wallpapers found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: controller.wallpapers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.68, // Tighter layout fit
            ),
            itemBuilder: (context, index) {
              final wallpaper = controller.wallpapers[index];

              return WallpaperCard(
                wallpaper: wallpaper,
                onTap: () => Get.to(() => WallpaperFullView(wallpaper: wallpaper)),
                onActionSelected: (value) {
                  switch (value) {
                    case 'save':
                      controller.saveWallpaper(wallpaper['id']);
                      break;
                    case 'set_lock':
                      controller.setWallpaper(wallpaper['background'], 'lock');
                      break;
                    case 'set_home':
                      controller.setWallpaper(wallpaper['background'], 'home');
                      break;
                    case 'set_both':
                      controller.setWallpaper(wallpaper['background'], 'both');
                      break;
                    case 'download':
                      controller.downloadWallpaper(wallpaper['background']);
                      break;
                    case 'share':
                    // Add share logic here
                      break;
                  }
                },
              );
            },

          );
        }),
      ),
    );
  }

  PopupMenuItem<String> _popupItem(IconData icon, String text) {
    return PopupMenuItem<String>(
      value: text.toLowerCase(),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.brown),
          SizedBox(width: 6.w),
          Text(text, style: const TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
