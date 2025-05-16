import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'quote_controller.dart';
import '../widgets/bottom_nav.dart';

class QuoteView extends StatelessWidget {
  final controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            Row(
              children: [
                Icon(Icons.arrow_right_alt, color: Colors.white),
                SizedBox(width: 4.w),
                Text("Top Quotes", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 16.h),

            ...controller.quotes.map((quote) {
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (quote['type'] == "image")
                      _buildImageCard(quote)
                    else
                      _buildTextCard(quote),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 12.w,
                      children: List<Widget>.from(
                        (quote['tags'] ?? []).map<Widget>(
                              (tag) => Text(tag, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                        ),
                      ),
                    ),
                    _quoteActions(),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(Map<String, dynamic> quote) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.asset(
        quote['background'],
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTextCard(Map<String, dynamic> quote) {
    return Container(
      height: 250.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Text(
          quote['text'],
          style: TextStyle(fontSize: 14.sp, color: Colors.black, height: 1.4),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _quoteActions() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconText(Icons.remove_red_eye, "567.57k"),
          _iconText(Icons.share, "Share"),
          _iconText(Icons.download, "Download"),
          _iconText(Icons.bookmark_border, "Save"),
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
