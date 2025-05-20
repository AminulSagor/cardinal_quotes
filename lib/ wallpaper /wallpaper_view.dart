import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
              child: Text('No wallpapers found.', style: TextStyle(color: Colors.white)),
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
              final tags = (wallpaper['tags'] ?? []) as List;
              final viewCount = wallpaper['views'] ?? 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 4.w,
                          runSpacing: 0,
                          children: tags.isNotEmpty
                              ? tags.take(2).map((tag) => Text(
                            '#$tag',
                            style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            overflow: TextOverflow.ellipsis,
                          )).toList()
                              : [Text('#Wallpaper', style: TextStyle(color: Colors.white, fontSize: 12.sp))],
                        ),
                      ),

                      PopupMenuButton<String>(
                        color: Colors.orange.shade50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
                        onSelected: (value) {
                          // Handle popup actions
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'views',
                            child: Row(
                              children: [
                                const Icon(Icons.remove_red_eye, size: 18, color: Colors.brown),
                                SizedBox(width: 6.w),
                                Text('$viewCount', style: const TextStyle(color: Colors.brown)),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          _popupItem(Icons.bookmark_border, "Save"),
                          _popupItem(Icons.share, "Share"),
                          _popupItem(Icons.download, "Download"),
                          _popupItem(Icons.wallpaper, "Set"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(
                      wallpaper['background'] ?? '',
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                      progress == null ? child : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, _, __) => Container(
                        height: 180.h,
                        color: Colors.black26,
                        child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
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
