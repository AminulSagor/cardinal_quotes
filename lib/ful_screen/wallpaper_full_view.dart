import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../combine_service/view_service.dart';

class WallpaperFullView extends StatelessWidget {
  final Map<String, dynamic> wallpaper;
  final viewService = ViewService();

  WallpaperFullView({super.key, required this.wallpaper}) {
    if (wallpaper['id'] != null) {
      viewService.increaseVisualView(wallpaper['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.network(
              wallpaper['background'] ?? '',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white),
            ),
          ),
          Positioned(
            top: 16.h,
            left: 12.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.close, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
