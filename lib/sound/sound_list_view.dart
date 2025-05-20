import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav.dart';
import 'sound_controller.dart';

class SoundListView extends StatelessWidget {
  final String category;

  SoundListView({super.key, required this.category});

  String _getTitle(String category) {
    switch (category) {
      case 'cardinal_sounds':
        return 'Cardinal Sounds';
      case 'nature_sounds':
        return 'Nature Sounds';
      case 'sleeping_sounds':
        return 'Sleeping Sounds';
      case 'meditation':
        return 'Meditation';
      case 'short_meditation':
        return 'Short Meditations';
      case 'motivational_audio':
        return 'Motivational Audios';
      default:
        return 'Sounds';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SoundController(category));

    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Icon(Icons.arrow_right_alt, color: Colors.white, size: 24.sp),
                  SizedBox(width: 4.w),
                  Text(
                    _getTitle(category),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            // Sound list or loader
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (controller.sounds.isEmpty) {
                    return Center(
                      child: Text(
                        'No sounds found.',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.sounds.length,
                    itemBuilder: (context, index) {
                      final sound = controller.sounds[index];
                      final image = sound['img_path'];
                      final title = sound['name'];
                      final audio = sound['audio_path'];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/sleep-sound',
                              arguments: {'category': category, 'audio': sound   ,   'duration': controller.durations[index]},
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image + Overlay
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
                                      errorBuilder:
                                          (_, __, ___) => Container(
                                            height: 200.h,
                                            color: Colors.grey,
                                            child: Center(
                                              child: Icon(
                                                Icons.broken_image,
                                                color: Colors.white,
                                              ),
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
                                      border: Border(
                                        top: BorderSide(
                                          color: const Color(0xFFFFF7EA),
                                          width: 8,
                                        ),
                                        right: BorderSide(
                                          color: const Color(0xFFFFF7EA),
                                          width: 12,
                                        ),
                                        bottom: BorderSide(
                                          color: const Color(0xFFFFF7EA),
                                          width: 60,
                                        ),
                                        left: BorderSide(
                                          color: const Color(0xFFFFF7EA),
                                          width: 12,
                                        ),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.play_arrow,
                                                    size: 18.sp,
                                                    color: Colors.brown,
                                                  ),
                                                  Text(
                                                    controller
                                                            .durations[index] ??
                                                        "00:00",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
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
                                ],
                              ),

                              SizedBox(height: 8.h),
                              Text(
                                "Music: $title",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Wrap(
                                spacing: 10.w,
                                children:
                                    ['Calm', 'Relax', 'Focus']
                                        .map(
                                          (tag) => Text(
                                            '#$tag',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '0',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Share",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Download",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bookmark_border,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
