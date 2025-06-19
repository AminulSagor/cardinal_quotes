import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../ful_screen/quote_full_view.dart';

class QuoteCardWidget extends StatelessWidget {
  final Map<String, dynamic> quote;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onDownload;

  const QuoteCardWidget({
    Key? key,
    required this.quote,
    required this.onSave,
    required this.onShare,
    required this.onDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Get.to(() => QuoteFullView(quote: quote)),
            child: quote['type'] == "image"
                ? _buildImageCard()
                : quote['type'] == "visual"
                ? _buildVisualCard()
                : _buildTextCard(),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 12.w,
            children: List<Widget>.from(
              (quote['tags'] ?? []).map<Widget>(
                    (tag) => Text(
                  '#$tag',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ),
          _quoteActions(),
        ],
      ),
    );
  }

  Widget _buildImageCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Image.network(
      quote['background'] ?? '',
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, loading) =>
      loading == null ? child : const Center(child: CircularProgressIndicator()),
      errorBuilder: (_, __, ___) => Container(
        height: 200.h,
        color: Colors.black26,
        child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
      ),
    ),
  );

  Widget _buildVisualCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.network(
          quote['background'] ?? '',
          width: double.infinity,
          height: 200.h,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, loading) =>
          loading == null ? child : const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, __, ___) => Container(
            height: 200.h,
            color: Colors.black26,
            child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
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
          ),
        ),
      ],
    ),
  );

  Widget _buildTextCard() => Container(
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

  Widget _quoteActions() => Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _iconText(Icons.remove_red_eye, quote['views']?.toString() ?? '0'),
        GestureDetector(onTap: onShare, child: _iconText(Icons.share, "Share")),
        GestureDetector(onTap: onDownload, child: _iconText(Icons.download, "Download")),
        GestureDetector(onTap: onSave, child: _iconText(Icons.bookmark_border, "Save")),
      ],
    ),
  );

  Widget _iconText(IconData icon, String label) => Row(
    children: [
      Icon(icon, color: Colors.white, size: 18.sp),
      SizedBox(width: 4.w),
      Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
    ],
  );
}
