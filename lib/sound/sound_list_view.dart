import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/sound_card_widget.dart';
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
                      return SoundCard(
                        sound: sound,
                        category: category,
                        duration: controller.durations[index] ?? "00:00",
                        onTap: () {
                          Get.toNamed(
                            '/sleep-sound',
                            arguments: {
                              'category': category,
                              'audio': sound,
                              'duration': controller.durations[index],
                            },
                          );
                        },
                        onSave: () => controller.saveAudio(sound['id']),
                        onShare: () {
                          // Share logic here
                        },
                        onDownload: () {
                          // Download logic here
                        },
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
