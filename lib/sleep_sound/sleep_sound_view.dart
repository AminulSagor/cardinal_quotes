import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'sleep_sound_controller.dart';

extension StringExtension on String {
  String get titleCase {
    return replaceAll('_', ' ')
        .split(' ')
        .map(
          (str) => str.isEmpty ? '' : str[0].toUpperCase() + str.substring(1),
        )
        .join(' ');
  }
}

class SleepSoundView extends StatelessWidget {
  final String category;
  final Map<String, dynamic> audio;
  final String? duration;

  SleepSoundView({
    super.key,
    required this.category,
    required this.audio,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SleepSoundController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init(audio['audio_path']);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_right_alt, color: Colors.white),
                  SizedBox(width: 4.w),
                  Text(
                    category.titleCase,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              // Card with image and Lottie animation
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7EA),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          audio['img_path'],
                          height: 180.h,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder:
                              (_, __, ___) => Container(
                                height: 180.h,
                                color: Colors.grey,
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Obx(() {
                        return Lottie.asset(
                          'assets/animation/music_wave.json',
                          width: 120.w,
                          height: 64.h,
                          repeat: true,
                          animate: controller.isPlaying.value,
                        );
                      }),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // Volume control
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Column(
                    children: [
                      GestureDetector(
                        onPanUpdate: (details) {
                          final localDy = details.localPosition.dy;
                          final totalHeight = 120.h;

                          double newVol = 1.0 - (localDy / totalHeight);
                          newVol = newVol.clamp(0.0, 1.0);

                          controller.setVolume(newVol);
                        },
                        child: Container(
                          height: 120.h,
                          width: 30.w, // increased width for better touch
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 120.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              Obx(() {
                                return Container(
                                  height: 120.h * controller.volume.value,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Icon(Icons.volume_up, color: Colors.white, size: 20.sp),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Time and Play Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      _formatTime(controller.currentTime.value),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -40.h),
                    child: GestureDetector(
                      behavior:
                          HitTestBehavior
                              .translucent, // ensures it captures taps even in transparent areas
                      onTap: controller.togglePlay,
                      child: Container(
                        padding: EdgeInsets.all(
                          8.w,
                        ), // expands the touchable area
                        alignment: Alignment.center,
                        child: Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Obx(
                            () => Center(
                              child: Icon(
                                controller.isPlaying.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 28.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    final isLoaded = controller.maxDuration.value > 1;
                    final fallback = duration ?? "00:00";
                    final display =
                        isLoaded
                            ? _formatTime(controller.maxDuration.value)
                            : fallback;
                    return Text(display, style: TextStyle(color: Colors.white));
                  }),
                ],
              ),
              SizedBox(height: 10.h),

              // Progress Bar
              Obx(() {
                return SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.brown,
                    thumbColor: Colors.transparent,
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                  ),
                  child: Slider(
                    value: controller.currentTime.value.clamp(
                      0.0,
                      controller.maxDuration.value,
                    ),
                    min: 0,
                    max: controller.maxDuration.value,
                    onChanged: (val) => controller.seek(val),
                  ),
                );
              }),
              SizedBox(height: 10.h),

              // Music info
              Text(
                "Music: ${audio['name']}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 4.h),
              Wrap(
                spacing: 8.w,
                children: [_tag("#Calm"), _tag("#Relax"), _tag("#Focus")],
              ),
              SizedBox(height: 12.h),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconText(Icons.remove_red_eye, "567.57k"),
                  _iconText(Icons.share, "Share"),
                  _iconText(Icons.download, "Download"),
                  _iconText(Icons.bookmark_border, "Save"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(double seconds) {
    final duration = Duration(seconds: seconds.toInt());
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  Widget _tag(String text) =>
      Text(text, style: TextStyle(color: Colors.white, fontSize: 12.sp));

  Widget _iconText(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20.sp),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      ],
    );
  }
}
