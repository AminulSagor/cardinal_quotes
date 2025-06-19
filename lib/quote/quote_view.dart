import 'package:cardinal/sleep_sound/sleep_sound_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../ful_screen/quote_full_view.dart';
import '../widgets/quote_card_widget.dart';
import 'quote_controller.dart';
import '../widgets/bottom_nav.dart';

class QuoteView extends StatelessWidget {
  final String category;
  final controller = Get.put(QuoteController());

  QuoteView({super.key, required this.category}) {
    controller.loadQuotes(category);
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

          if (controller.quotes.isEmpty) {
            return const Center(
              child: Text(
                'No quotes found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_right_alt, color: Colors.white),
                  SizedBox(width: 4.w),
                  Text(
                    category.titleCase,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ...controller.quotes.map((quote) {
                return QuoteCardWidget(
                  quote: quote,
                  onSave: () => controller.saveQuote(quote['id']),
                  onShare: () => print('Share quote ${quote['id']}'),
                  onDownload: () => print('Download quote ${quote['id']}'),
                );
              }),

            ],
          );
        }),
      ),
    );
  }

  Widget _buildImageCard(Map<String, dynamic> quote) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.network(
        quote['background'] ?? '',
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder:
            (context, child, progress) =>
                progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
        errorBuilder:
            (context, _, __) => Container(
              height: 200.h,
              color: Colors.black26,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
      ),
    );
  }

  Widget _buildVisualCard(Map<String, dynamic> quote) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.network(
            quote['background'] ?? '',
            width: double.infinity,
            fit: BoxFit.cover,
            height: 200.h,
            loadingBuilder:
                (context, child, progress) =>
                    progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
            errorBuilder:
                (context, _, __) => Container(
                  height: 200.h,
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12.r),
              ),
              // child: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     const Icon(Icons.remove_red_eye, size: 14, color: Colors.white),
              //     SizedBox(width: 4.w),
              //     // Text(
              //     //   '${quote['views'] ?? 0}',
              //     //   style: TextStyle(color: Colors.white, fontSize: 12.sp),
              //     // ),
              //   ],
              // ),
            ),
          ),
        ],
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
          quote['text'] ?? '',
          style: TextStyle(fontSize: 14.sp, color: Colors.black, height: 1.4),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _quoteActions(Map<String, dynamic> quote) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconText(Icons.remove_red_eye, quote['views']?.toString() ?? '0'),
          _iconText(Icons.share, "Share"),
          _iconText(Icons.download, "Download"),
          GestureDetector(
            onTap: () => controller.saveQuote(quote['id']),
            child: _iconText(Icons.bookmark_border, "Save"),
          ),
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
