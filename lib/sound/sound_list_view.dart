import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav.dart';
import 'sound_controller.dart';

class SoundListView extends StatelessWidget {
  final controller = Get.put(SoundController());

  SoundListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Icon(Icons.arrow_right_alt, color: Colors.white, size: 24.sp),
                  SizedBox(width: 4.w),
                  Text(
                    "Sleep Sounds",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(() => ListView.builder(
                  itemCount: controller.sounds.length,
                  itemBuilder: (context, index) {
                    final sound = controller.sounds[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Image.asset(
                                  sound.imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200.h,
                                ),
                              ),
                              Container(
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
                                child: Stack(
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
                              )

                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Music: ${sound.title}",
                            style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4.h),
                          Wrap(
                            spacing: 10.w,
                            children: sound.tags.map((tag) => Text(
                              '#$tag',
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            )).toList(),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(Icons.remove_red_eye, color: Colors.white, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(sound.views, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                              ]),
                              Row(children: [
                                Icon(Icons.share, color: Colors.white, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text("Share", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                              ]),
                              Row(children: [
                                Icon(Icons.download, color: Colors.white, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text("Download", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                              ]),
                              Row(children: [
                                Icon(Icons.bookmark_border, color: Colors.white, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text("Save", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
