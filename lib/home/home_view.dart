import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../ wallpaper /wallpaper_view.dart';
import '../quote/quote_view.dart';
import '../sound/sound_list_view.dart';
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
    {'asset': 'assets/meditational_audios.png', 'label': 'Motivational Audios'},
    {'asset': 'assets/top_quotes.png', 'label': 'Top \nQuotes'},
    {'asset': 'assets/soul_check_in.png', 'label': 'Soul \nCheck-In'},
    {'asset': 'assets/Sacred_journals.png', 'label': 'Sacred \nJournals'},
    {'asset': 'assets/medicine_notes.png', 'label': 'Medicine \nNotes'},
    {'asset': 'assets/memorial_cards.png', 'label': 'Memorial \nCards'},
    {'asset': 'assets/save.png', 'label': 'Save'},
    {'asset': 'assets/cardinal_quotes.png', 'label': 'Cardinal \nQuotes'},
  ];

  final List<Map<String, dynamic>> topMenu = [
    {'icon': Icons.menu, 'label': 'drawer'},
    {'icon': Icons.local_fire_department, 'label': 'Popular'},
    {'icon': Icons.new_releases, 'label': 'Latest'},
    {'icon': Icons.sentiment_very_dissatisfied, 'label': 'Grief & Loss'},
    {'icon': Icons.book, 'label': 'Poems & Poetry'},
    {'icon': Icons.remember_me, 'label': 'Remembering'},
    {'icon': Icons.cloud, 'label': 'Heavenly'},
    {'icon': Icons.favorite, 'label': 'Faith & Hope'},
    {'icon': Icons.mail, 'label': 'Letters to Heaven'},
    {'icon': Icons.favorite_border, 'label': 'Love'},
    {'icon': Icons.family_restroom, 'label': 'Mom & Dad'},
    {'icon': Icons.healing, 'label': 'Healing from Regret'},
    {'icon': Icons.self_improvement, 'label': 'Stress Relief'},
    {'icon': Icons.volunteer_activism, 'label': 'Husband & Wife'},
    {'icon': Icons.diversity_1, 'label': 'Compassion'},
    {'icon': Icons.pets, 'label': 'Pet Loss'},
    {'icon': Icons.check, 'label': 'Forgiveness'},
    {'icon': Icons.emoji_emotions, 'label': 'Happy'},
    {'icon': Icons.forest, 'label': 'Cardinal Goddess'},
    {'icon': Icons.thumb_up, 'label': 'Encouraging'},
    {'icon': Icons.wb_sunny, 'label': 'Positive Thinking'},
    {'icon': Icons.self_improvement_outlined, 'label': 'Self Love'},
    {'icon': Icons.lightbulb, 'label': 'Wisdom'},
    {'icon': Icons.card_giftcard, 'label': 'Gratitude'},
    {'icon': Icons.center_focus_strong, 'label': 'Focus & Productivity'},
    {'icon': Icons.warning, 'label': 'Overcoming Worry'},
    {'icon': Icons.cake, 'label': 'Fathers/Mothers Day'},
    {'icon': Icons.wb_twilight, 'label': 'Morning Motivation'},
    {'icon': Icons.nightlight_round, 'label': 'Nighttime Peace'},
    {'icon': Icons.security, 'label': 'Courage & Confidence'},
  ];

  String _mapLabelToCategory(String label) {
    final normalized = label.replaceAll('\n', '').replaceAll(' ', '').toLowerCase();

    switch (normalized) {
      case 'cardinalsounds':
        return 'cardinal_sounds';
      case 'naturesounds':
        return 'nature_sounds';
      case 'sleepingsounds':
        return 'sleeping_sounds';
      case 'meditation':
        return 'meditation';
      case 'shortmeditations':
        return 'short_meditation';
      case 'motivationalaudios':
        return 'motivational_audio';
      default:
        return '';
    }
  }

  Widget buildTopMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: topMenu.map((e) {
            if (e['label'] == 'drawer') {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(e['icon'], color: Colors.white, size: 24.sp),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
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
                    Text(e['label'], style: TextStyle(color: Colors.brown, fontSize: 14.sp)),
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
                  Image.asset('assets/arrow.png', width: 18.w, height: 18.h),
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
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  items[i],
                  width: 100.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildQuoteSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text('Featured Quotes', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),

            ),
            Spacer(),
            Text('See All', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            SizedBox(width: 4.w),
            Image.asset('assets/arrow.png', width: 18.w, height: 18.h),
            SizedBox(width: 20.w),
          ],
        ),
        SizedBox(
          height: 140.h, // updated height to match others
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.quotes.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, i) {
              final quote = controller.quotes[i];
              final isText = quote['is_text'] == 1;
              return Container(
                width: 100.w, // updated width to match others
                padding: isText ? EdgeInsets.all(8.w) : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: isText ? Colors.white.withOpacity(0.9) : null,
                ),
                child: isText
                    ? Center(
                  child: Text(
                    quote['quote'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, color: Colors.brown),
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    quote['quote'],
                    fit: BoxFit.cover,
                    width: 100.w,
                    height: 140.h,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.black26,
                      child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
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
              Text('Announcement', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
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
          SizedBox(
            height: 160.h,
            child: Obx(() {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.announcements.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (_, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    controller.announcements[index],
                    width: 280.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 280.w,
                      color: Colors.black26,
                      child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
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
                  onPressed: () {
                    final label = e['label']!;
                    final category = _mapLabelToCategory(label);
                    final normalized = label.replaceAll('\n', '').toLowerCase();

                    if (normalized == 'top quotes') {
                      Get.to(() => QuoteView(category: 'top_quotes'));
                    } else if (normalized == 'cardinal quotes') {
                      Get.to(() => QuoteView(category: 'cardinal_quotes'));
                    } else if (normalized == 'memorial cards') {
                      Get.to(() => QuoteView(category: 'memorial_card'));
                    } else if (label == 'Wallpaper') {
                      Get.to(() => WallpaperView(category: 'wallpaper'));
                    } else if (category.isNotEmpty) {
                      Get.to(() => SoundListView(category: category));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.brown.shade900,
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, double.infinity),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(e['asset']!, width: 28.w, height: 28.h),
                      SizedBox(height: 6.h),
                      Text(e['label']!, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          buildSection("Featured Wallpaper", controller.wallpapers),
          buildQuoteSection(),
          buildSection("Featured Memorial Cards", controller.memorialCards),
          buildAnnouncementSection(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
      drawer: Container(
        width: 230.w,
        margin: EdgeInsets.only(
          top: 40.h,
          bottom: 20.h,
          left: 12.w,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Drawer(
            backgroundColor: const Color(0xFFFEF0D6), // ✅ Updated background color
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  color: const Color(0xFFFEF0D6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '"Peace comes from within.\nDo not seek it without."',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.brown, fontSize: 14.sp),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Buddha',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),

                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Image.asset(
                            'assets/drawer_first.png',
                            width: 100.w,     // Increased from 40 to 60
                            height: 100.h,    // Optional: set height to match proportion
                            fit: BoxFit.contain, // Ensures image stays within bounds
                          ),

                          Image.asset(
                            'assets/drawer_second.png',
                            width: 120.w,     // Increased from 40 to 60
                            height: 120.h,    // Optional: set height to match proportion
                            fit: BoxFit.contain, // Ensures image stays within bounds
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                _drawerItem(Icons.local_fire_department, 'Popular'),
                _drawerItem(Icons.new_releases, 'Latest'),
                _drawerItem(Icons.spa, 'Meditation'),
                _drawerItem(Icons.book, 'Top Quotes'),
                _drawerItem(Icons.note, 'Sacred Journals'),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.brown),
                  title: Text('Log Out', style: TextStyle(color: Colors.brown)),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
        ),
      ),




    );

  }
}
Widget _drawerItem(IconData icon, String label) {
  return ListTile(
    leading: Icon(icon, color: Colors.brown),
    title: Text(label, style: TextStyle(color: Colors.brown)),
    onTap: () {
      Get.back(); // close drawer
      // Add navigation if needed
    },
  );
}
