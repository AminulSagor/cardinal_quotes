import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'save_controller.dart';

class SaveView extends StatelessWidget {
  final controller = Get.put(SaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(Icons.arrow_right_alt, color: Colors.white),
                  SizedBox(width: 4.w),
                  Text("Save", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ],
              ),
              SizedBox(height: 16.h),

              // Tabs
              Obx(() {
                return Row(
                  children: [
                    _tabButton("Audios", 'audio'),
                    SizedBox(width: 12.w),
                    _tabButton("Quotes", 'quote'),
                  ],
                );
              }),
              SizedBox(height: 20.h),

              // Content
              Obx(() {
                return controller.selectedTab.value == 'audio'
                    ? _buildAudio(controller.audios.first)
                    : _buildQuote(controller.quotes.first);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String label, String key) {
    final isSelected = controller.selectedTab.value == key;
    return GestureDetector(
      onTap: () => controller.selectedTab.value = key,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF7EA) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFFFF7EA), width: 1),
        ),
        child: Row(
          children: [
            Icon(key == 'audio' ? Icons.music_note : Icons.format_quote,
                color: isSelected ? Colors.brown : Colors.white,
                size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.brown : Colors.white,
                fontSize: 12.sp,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAudio(Map<String, dynamic> audio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            image: DecorationImage(
              image: AssetImage(audio["image"]),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(20.w),
          child: Center(
            child: Container(
              width: 170.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
                border: Border(
                  top: BorderSide(color: const Color(0xFFFFF7EA), width: 8),
                  right: BorderSide(color: const Color(0xFFFFF7EA), width: 12),
                  bottom: BorderSide(color: const Color(0xFFFFF7EA), width: 60),
                  left: BorderSide(color: const Color(0xFFFFF7EA), width: 12),
                ),
              ),
              child:  Stack(
                children: [
                  // Waveform centered
                  Align(
                    alignment: Alignment.center,
                    child: Transform.translate(
                      offset: Offset(0, -2.h), // move up by 10 logical pixels
                      child: Image.asset(
                        'assets/wave.png',
                        height: 50.h,
                        color: const Color(0xFFFFF7EA),
                      ),
                    ),
                  ),

                  // Bottom overlay
                  Transform.translate(
                    offset: Offset(0, 90.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.play_arrow, size: 18.sp, color: Colors.brown),
                            Text("10.00", style: TextStyle(fontSize: 12.sp, color: Colors.brown)),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          height: 2.h,
                          color: Colors.brown,
                        ),
                      ],
                    ),
                  ),

                  // Title below the line

                  Transform.translate(
                    offset: Offset(0, 85.h),
                    child: Center(
                      child: Text(
                        "Wiper",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        _tags(audio["tags"]),
        _actionRow(),
      ],
    );
  }


  Widget _buildQuote(Map<String, dynamic> quote) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image quote with text over it
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              Image.asset(quote["background"], fit: BoxFit.cover, width: double.infinity),
              Positioned.fill(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          quote["text"],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp, color: Colors.black, height: 1.4),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          quote["author"],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        _tags(quote["tags"]),
        _actionRow(),
      ],
    );
  }

  Widget _tags(List<String> tags) {
    return Wrap(
      spacing: 10.w,
      children: tags
          .map((tag) => Text(tag, style: TextStyle(color: Colors.white, fontSize: 12.sp)))
          .toList(),
    );
  }

  Widget _actionRow() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconText(Icons.remove_red_eye, "567.57k"),
          _iconText(Icons.share, "Share"),
          _iconText(Icons.download, "Download"),
          _iconText(Icons.bookmark, "Save"),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18.sp),
        SizedBox(width: 4.w),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      ],
    );
  }
}
