import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'save_controller.dart';

class SaveView extends StatelessWidget {
  final String category;
  final SaveController controller;

  SaveView({super.key, required this.category})
      : controller = Get.put(SaveController(category));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    const Icon(Icons.arrow_right_alt, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      category.replaceAll('_', ' ').capitalizeFirst ?? 'Saved Items',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),

                  ],
                ),
                SizedBox(height: 16.h),

                // Tab Bar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Row(
                    children: [

                      _tab("Quotes", "quote", Icons.format_quote),
                      _tab("Audios", "audio", Icons.music_note),
                      _tab("Wallpapers", "wallpaper", Icons.wallpaper),
                      _tab("Memorial Cards", "memorial", Icons.book),
                    ],
                  )),
                ),

                SizedBox(height: 20.h),

                // Tab Content
                Expanded(child: Obx(() => _buildTabContent())),
              ],
            ),
          );
        }),
      ),
    );
  }


  Widget _tab(String title, String key, IconData icon) {
    final isSelected = controller.selectedTab.value == key;
    return GestureDetector(
      onTap: () => controller.onTabChanged(key),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF7EA) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFFFF7EA), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16.sp, color: isSelected ? Colors.brown : Colors.white),
            SizedBox(width: 6.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected ? Colors.brown : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (controller.selectedTab.value) {
      case 'audio':
        return controller.audios.isEmpty
            ? _emptyText()
            : ListView.builder(
          itemCount: controller.audios.length,
          itemBuilder: (_, i) => controller.buildAudioCard(controller.audios[i], i),
        );
      case 'quote':
        return controller.quotes.isEmpty
            ? _emptyText()
            : ListView.builder(
          itemCount: controller.quotes.length,
          itemBuilder: (_, i) => controller.buildQuoteCard(controller.quotes[i]),
        );
      case 'wallpaper':
        return controller.wallpapers.isEmpty
            ? _emptyText()
            : GridView.builder(
          itemCount: controller.wallpapers.length,
          //padding: EdgeInsets.only(top: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (_, i) => controller.buildImageCard(controller.wallpapers[i]),
        );
      case 'memorial':
        return controller.memorials.isEmpty
            ? _emptyText()
            : ListView.builder(
          itemCount: controller.memorials.length,
          itemBuilder: (_, i) =>
              controller.buildQuoteCard(controller.memorials[i]),
        );

      default:
        return _emptyText();
    }
  }

  Widget _emptyText() => Center(
    child: Text('No items found.',
        style: TextStyle(color: Colors.white, fontSize: 14.sp)),
  );
}
