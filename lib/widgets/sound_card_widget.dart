import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SoundCard extends StatelessWidget {
  final Map sound;
  final String category;
  final String duration;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onDownload;

  const SoundCard({
    super.key,
    required this.sound,
    required this.category,
    required this.duration,
    required this.onTap,
    required this.onSave,
    required this.onShare,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final image = sound['img_path'];
    final title = sound['name'];

    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.h,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200.h,
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 170.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: const Border(
                      top: BorderSide(color: Color(0xFFFFF7EA), width: 8),
                      right: BorderSide(color: Color(0xFFFFF7EA), width: 12),
                      bottom: BorderSide(color: Color(0xFFFFF7EA), width: 60),
                      left: BorderSide(color: Color(0xFFFFF7EA), width: 12),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: Offset(0, -2.h),
                          child: Image.asset(
                            'assets/wave.png',
                            height: 50.h,
                            color: const Color(0xFFFFF7EA),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 90.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.play_arrow, size: 18.sp, color: Colors.brown),
                                Text(duration, style: TextStyle(fontSize: 12.sp, color: Colors.brown)),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Container(height: 2.h, color: Colors.brown),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 85.h),
                        child: Center(
                          child: Text("Wiper", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.brown)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text("Music: $title", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 4.h),
            Wrap(
              spacing: 10.w,
              children: ['Calm', 'Relax', 'Focus'].map((tag) {
                return Text('#$tag', style: TextStyle(color: Colors.white, fontSize: 12.sp));
              }).toList(),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.remove_red_eye, color: Colors.white, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text('${sound['view_count'] ?? 0}', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  ],
                ),
                GestureDetector(
                  onTap: onShare,
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text("Share", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onDownload,
                  child: Row(
                    children: [
                      Icon(Icons.download, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text("Download", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onSave,
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_border, color: Colors.white, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text("Save", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
