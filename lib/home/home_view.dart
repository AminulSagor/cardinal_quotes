import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../widgets/bottom_nav.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());

  final List<Map<String, String>> buttons = [
    {'asset': 'assets/bird.png', 'label': 'Cardinal \nSounds'},
    {'asset': 'assets/image.png', 'label': 'Wallpaper'},
    {'asset': 'assets/bird_music.png', 'label': 'Nature \nSounds'},
    {'asset': 'assets/sleeping_sounds.png', 'label': 'Sleeping \nSounds'},
    {'asset': 'assets/meditation.png', 'label': 'Meditation'},
    {'asset': 'assets/breathing_exercises.png', 'label': 'Breathing Exercises'},
    {'asset': 'assets/short_meditations.png', 'label': 'Short Meditations'},
    {'asset': 'assets/meditational_audios.png', 'label': 'Meditational Audios'},
    {'asset': 'assets/top_quotes.png', 'label': 'Top \nQuotes'},
    {'asset': 'assets/soul_check_in.png', 'label': 'Soul \nCheck-In'},
    {'asset': 'assets/Sacred_journals.png', 'label': 'Sacred \nJournals'},
    {'asset': 'assets/medicine_notes.png', 'label': 'Medicine \nNotes'},
    {'asset': 'assets/memorial_cards.png', 'label': 'Memorial \nCards'},
    {'asset': 'assets/save.png', 'label': 'Save'},
    {'asset': 'assets/cardinal_quotes.png', 'label': 'Cardinal \nQuotes'},
  ];

  final List<Map<String, dynamic>> topMenu = [
    {'icon': Icons.menu, 'label': ''},
    {'icon': Icons.local_fire_department, 'label': 'Popular'},
    {'icon': Icons.new_releases, 'label': 'Latest'},
    {'icon': Icons.sentiment_satisfied_alt, 'label': 'kisu akta'},
  ];

  Widget buildTopMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: topMenu.map((e) {
            if (e['label'] == '') {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: IconButton(
                  icon: Icon(e['icon'], color: Colors.white, size: 24.sp),
                  onPressed: () {
                    // open drawer
                  },
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(e['icon'], size: 20.sp, color: Colors.brown),
                    SizedBox(width: 6.w),
                    Text(
                      e['label'],
                      style: TextStyle(color: Colors.brown, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
              Row(
                children: [
                  Text('See All', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                  SizedBox(width: 4.w),
                  Image.asset(
                    'assets/arrow.png',
                    width: 18.w,
                    height: 18.h,
                  ),
                ],
              ),


            ],
          ),
        ),
        SizedBox(
          height: 140.h,
          child: Obx(() {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(items[i], width: 100.w, fit: BoxFit.cover),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemCount: items.length,
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8A3C24),
      body: ListView(
        padding: EdgeInsets.only(top: 16.h, bottom: 80.h),
        children: [
          SizedBox(height: 20.h),
          buildTopMenu(),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.w,
            runSpacing: 12.h,
            children: buttons.map((e) {
              return SizedBox(
                width: 100.w,
                height: 100.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.brown.shade900,
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, double.infinity), // fills the SizedBox
                    padding: EdgeInsets.zero, // remove internal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(e['asset']!, width: 28.w, height: 28.h),
                      SizedBox(height: 6.h),
                      Text(
                        e['label']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              );

            }).toList(),
          ),
          SizedBox(height: 16.h),
          buildSection("Featured Wallpaper", controller.wallpapers),
          buildSection("Featured Quotes", controller.quotes),
          buildSection("Featured Memorial Cards", controller.memorialCards),
          buildAnnouncementSection(),

        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
  Widget buildAnnouncementSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Announcement',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Row(
                children: [
                  Text('See All', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                  SizedBox(width: 4.w),
                  Image.asset('assets/arrow.png', width: 16.w, height: 16.h),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/announcement.png', // Replace with your actual announcement image
              width: double.infinity,
              height: 160.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

}
