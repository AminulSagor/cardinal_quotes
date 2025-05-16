import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'sleep_sound_controller.dart';

class SleepSoundView extends StatelessWidget {
  final controller = Get.put(SleepSoundController());

  @override
  Widget build(BuildContext context) {
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
                  Text("Sleep Sounds", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ],
              ),
              SizedBox(height: 40.h),

              // Card with image and waveform
              Center(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7EA),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset('assets/car.png', height: 180.h, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 20.h),
                      Image.asset('assets/wave.png', height: 50.h, color: const Color(0xFF3E2012)),
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
                      Container(
                        height: 120.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Obx(() {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 120.h * controller.volume.value,
                              width: 10.w,
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          );
                        }),
                      ),
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
                  Text("04.00", style: TextStyle(color: Colors.white)),
                  InkWell(
                    onTap: controller.togglePlay,
                    child: Transform.translate(
                      offset: Offset(0, -40.h), // adjust vertical position
                      child: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Center(
                          child: Icon(Icons.play_arrow, size: 28.sp, color: Colors.white),
                        ),
                      ),
                    ),

                  ),
                  Text("12.00", style: TextStyle(color: Colors.white)),
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
                    value: controller.currentTime.value,
                    min: 0,
                    max: 12,
                    onChanged: (val) => controller.currentTime.value = val,
                  ),
                );
              }),

              SizedBox(height: 10.h),

              // Music info
              Text("Music: Owl", style: TextStyle(color: Colors.white)),
              SizedBox(height: 4.h),
              Wrap(
                spacing: 8.w,
                children: [
                  _tag("#Ambition"),
                  _tag("#Inspiration"),
                  _tag("#Motivitioanal"),
                ],
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String text) => Text(text, style: TextStyle(color: Colors.white, fontSize: 12.sp));

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
