import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../ wallpaper /wallpaper_view.dart';
import '../journal/journal_view.dart';
import '../quote/quote_view.dart';
import '../save/save_view.dart';
import '../soul_checking/soul_checking_view.dart';
import '../sound/sound_list_view.dart';
import '../todo/todo_view.dart';
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
    {'asset': 'assets/save.png', 'label': 'Saved'},
    {'asset': 'assets/cardinal_quotes.png', 'label': 'Cardinal \nQuotes'},
  ];

  final List<Map<String, String>> topMenu = [
    // {'asset': 'assets/drawer_icon.png', 'label': 'drawer'},
    {'asset': 'assets/popular_icon.png', 'label': 'Popular'},
    {'asset': 'assets/latest_icon.png', 'label': 'Latest'},
    {'asset': 'assets/top_menu/grief_loss.png', 'label': 'Grief & Loss'},
    {'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Poems & Poetry'},
    {'asset': 'assets/top_menu/remembering.png', 'label': 'Remembering'},
    {'asset': 'assets/top_menu/heavenly.png', 'label': 'Heavenly'},
    {'asset': 'assets/top_menu/faith_hope.png', 'label': 'Faith & Hope'},
    {
      'asset': 'assets/top_menu/letters_heaven.png',
      'label': 'Letters to Heaven',
    },
    {'asset': 'assets/top_menu/love.png', 'label': 'Love'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Mom & Dad'},
    {'asset': 'assets/top_menu/healing.png', 'label': 'Healing from Regret'},
    {'asset': 'assets/top_menu/stress.png', 'label': 'Stress Relief'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Husband & Wife'},
    {'asset': 'assets/top_menu/compassion.png', 'label': 'Compassion'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Pet Loss'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Forgiveness'},
    {'asset': 'assets/top_menu/happy.png', 'label': 'Happy'},
    // {'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Cardinal Goddess'},
    {'asset': 'assets/top_menu/encouraging.png', 'label': 'Encouraging'},
    {
      'asset': 'assets/top_menu/positive_thinking.png',
      'label': 'Positive Thinking',
    },
    {'asset': 'assets/top_menu/self_love.png', 'label': 'Self Love'},
    {'asset': 'assets/top_menu/wisdom.png', 'label': 'Wisdom'},
    {'asset': 'assets/top_menu/gratitude.png', 'label': 'Gratitude'},
    {'asset': 'assets/top_menu/focus.png', 'label': 'Focus & Productivity'},
    {'asset': 'assets/top_menu/worry.png', 'label': 'Overcoming Worry'},
    // {'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Fathers/Mothers Day'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Morning Motivation'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Nighttime Peace'},
    //{'asset': 'assets/top_menu/poems_poetry.png', 'label': 'Courage & Confidence'},
  ];

  final Map<String, String> labelToKeyword = {
    'Popular': 'popular',
    'Latest': 'latest',
    'Grief & Loss': 'grief_loss',
    'Poems & Poetry': 'poems_poetry',
    'Remembering': 'remembering',
    'Heavenly': 'heavenly',
    'Faith & Hope': 'faith_hope',
    'Letters to Heaven': 'letters_to_heaven',
    'Love': 'love',
    'Healing from Regret': 'healing_from_regret',
    'Stress Relief': 'stress_relief',
    'Compassion': 'compassion',
    'Happy': 'happy',
    'Encouraging': 'encouraging',
    'Positive Thinking': 'positive_thinking',
    'Self Love': 'self_love',
    'Wisdom': 'wisdom',
    'Gratitude': 'gratitude',
    'Focus & Productivity': 'focus_productivity',
    'Overcoming Worry': 'overcoming_worry',
    // Add more as needed
  };

  String _mapLabelToCategory(String label) {
    final normalized =
        label.replaceAll('\n', '').replaceAll(' ', '').toLowerCase();

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
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              topMenu.map((e) {
                if (e['label'] == 'drawer') {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Builder(
                      builder:
                          (context) => IconButton(
                            icon: Image.asset(
                              e['asset']!,
                              width: 24.w,
                              height: 24.h,
                              color: Colors.white,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      final label = e['label']!;
                      final keyword = labelToKeyword[label];

                      if (keyword != null && keyword.isNotEmpty) {
                        Get.to(() => SaveView(category: keyword));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            e['asset']!,
                            width: 20.w,
                            height: 20.h,
                            color: Colors.brown,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            e['label']!,
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
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
              itemBuilder:
                  (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      items[i],
                      width: 100.w,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                          ),
                    ),
                  ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildQuoteSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  'Featured Quotes',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Text(
                'See All',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
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
                  child:
                      isText
                          ? Center(
                            child: Text(
                              quote['quote'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.brown,
                              ),
                            ),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              quote['quote'],
                              fit: BoxFit.cover,
                              width: 100.w,
                              height: 140.h,
                              errorBuilder:
                                  (_, __, ___) => Container(
                                    color: Colors.black26,
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                );
              },
            ),
          ),
        ],
      ),
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
              Text(
                'Announcement',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
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
                itemBuilder:
                    (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        controller.announcements[index]['image_path'],
                        width: 280.w,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              width: 280.w,
                              color: Colors.black26,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                              ),
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
          Padding(
            padding: EdgeInsets.only(left: 23.w, top: 16.h),
            child: Row(
              children: [
                Builder(
                  builder:
                      (context) => GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Image.asset(
                          'assets/drawer_icon.png',
                          width: 28.w,
                          height: 28.h,
                          color: Colors.white,
                        ),
                      ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: buildTopMenu(),
                ), // make top menu take rest of space
              ],
            ),
          ),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.w,
            runSpacing: 12.h,
            children:
                buttons.map((e) {
                  return SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: ElevatedButton(
                      onPressed: () {
                        final label = e['label']!;
                        final category = _mapLabelToCategory(label);
                        final normalized =
                            label.replaceAll('\n', '').toLowerCase();

                        if (normalized == 'top quotes') {
                          Get.to(() => QuoteView(category: 'top_quotes'));
                        } else if (normalized == 'cardinal quotes') {
                          Get.to(() => QuoteView(category: 'cardinal_quotes'));
                        } else if (normalized == 'memorial cards') {
                          Get.to(() => QuoteView(category: 'memorial_card'));
                        } else if (normalized == 'sacred journals') {
                          Get.to(() => JournalView());
                        } else if (normalized == 'saved') {
                          Get.to(() => SaveView(category: 'saved'));
                        } else if (normalized == 'soul check-in') {
                          Get.to(() => SoulCheckingView());
                        } else if (normalized == 'medicine notes') {
                          Get.to(() => TodoView());
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
          buildQuoteSection(),
          buildSection("Featured Memorial Cards", controller.memorialCards),
          buildAnnouncementSection(),
        ],
      ),

      bottomNavigationBar: const BottomNavBar(),
      drawer: Container(
        width: 225.w,
        margin: EdgeInsets.only(top: 40.h, bottom: 20.h, left: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Drawer(
            backgroundColor: const Color(0xFFFEF0D6),
            child: Column(
              children: [
                // Top: Buddha quote and images
                Container(
                  color: const Color(0xFFFEF0D6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '"Peace comes from within.\nDo not seek it without."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Transform.translate(
                        offset: Offset(87.w, 0),
                        child: Text(
                          'Buddha',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Transform.translate(
                            offset: Offset(-2.w, -60),
                            child: Image.asset(
                              'assets/drawer_first.png',
                              width: 90.w,
                              height: 100.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(25.w, -25),
                            child: Transform.scale(
                              scale: 1.7,
                              child: Image.asset(
                                'assets/drawer_second.png',
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Middle: scrollable drawer items
                Expanded(
                  child: Transform.translate(
                    offset: Offset(10, -40.h),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        //_drawerItem('assets/explore_ion.png', 'Explore'),
                        ...[
                          {
                            'asset': 'assets/popular_icon.png',
                            'label': 'Popular',
                          },
                          {
                            'asset': 'assets/latest_icon.png',
                            'label': 'Latest',
                          },
                          {
                            'asset': 'assets/bird.png',
                            'label': 'Cardinal Sound',
                          },
                          {'asset': 'assets/image.png', 'label': 'Wallpaper'},
                          {
                            'asset': 'assets/bird_music.png',
                            'label': 'Natural Sound',
                          },
                          {
                            'asset': 'assets/sleeping_sounds.png',
                            'label': 'Sleeping',
                          },
                          {
                            'asset': 'assets/meditation.png',
                            'label': 'Meditation',
                          },
                          {
                            'asset': 'assets/breathing_exercises.png',
                            'label': 'Breathing Exercise',
                          },
                          {
                            'asset': 'assets/meditational_audios.png',
                            'label': 'Motivational Audios',
                          },
                          {
                            'asset': 'assets/short_meditations.png',
                            'label': 'Short Meditation',
                          },
                          {
                            'asset': 'assets/top_quotes.png',
                            'label': 'Top Quotes',
                          },
                          {
                            'asset': 'assets/soul_check_in.png',
                            'label': 'Soul Check-In',
                          },
                          {
                            'asset': 'assets/Sacred_journals.png',
                            'label': 'Sacred Journals',
                          },
                          {
                            'asset': 'assets/medicine_notes.png',
                            'label': 'Medicine Note',
                          },
                          {
                            'asset': 'assets/memorial_cards.png',
                            'label': 'Memorial Card',
                          },
                          {'asset': 'assets/save.png', 'label': 'Save'},
                        ].map((item) {
                          return _drawerItem(
                            item['asset']!,
                            item['label']!,
                            onTap: () {
                              Get.back(); // Close drawer
                              final label = item['label']!;
                              final normalized =
                                  label.replaceAll('\n', '').toLowerCase();

                              if (normalized == 'top quotes') {
                                Get.to(() => QuoteView(category: 'top_quotes'));
                              } else if (normalized == 'cardinal sound') {
                                Get.to(
                                  () => SoundListView(
                                    category: 'cardinal_sounds',
                                  ),
                                );
                              } else if (normalized == 'natural sound') {
                                Get.to(
                                  () => SoundListView(
                                    category: 'cardinal_sounds',
                                  ),
                                );
                              } else if (normalized == 'sleeping') {
                                Get.to(
                                      () => SoundListView(
                                    category: 'sleeping_sounds',
                                  ),
                                );
                              } else if (normalized == 'meditation') {
                                Get.to(
                                      () => SoundListView(
                                    category: 'meditation',
                                  ),
                                );
                              }else if (normalized == 'short meditation') {
                                Get.to(
                                      () => SoundListView(
                                    category: 'short_meditation',
                                  ),
                                );
                              }  else if (normalized == 'memorial cards' ||
                                  normalized == 'memorial card') {
                                Get.to(
                                  () => QuoteView(category: 'memorial_card'),
                                );
                              } else if (normalized == 'sacred journals') {
                                Get.to(() => JournalView());
                              } else if (normalized == 'saved' ||
                                  normalized == 'save') {
                                Get.to(() => SaveView(category: 'saved'));
                              } else if (normalized == 'soul check-in') {
                                Get.to(() => SoulCheckingView());
                              } else if (normalized == 'medicine notes' ||
                                  normalized == 'medicine note') {
                                Get.to(() => TodoView());
                              } else if (label == 'Wallpaper') {
                                Get.to(
                                  () => WallpaperView(category: 'wallpaper'),
                                );
                              } else if (label == 'Popular' ||
                                  label == 'Latest') {
                                final keyword = label.toLowerCase();
                                Get.to(() => SaveView(category: keyword));
                              } else {
                                final category = _mapLabelToCategory(label);
                                if (category.isNotEmpty) {
                                  Get.to(
                                    () => SoundListView(category: category),
                                  );
                                }
                              }
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),

                // Bottom: Logout button
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width:
                            110.w, // Set width to center the ListTile visually
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -4),
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                          leading: Icon(Icons.logout, color: Colors.brown),
                          title: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.brown),
                          ),
                          onTap: () {
                            // Handle logout
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _drawerItem(String assetPath, String label, {VoidCallback? onTap}) {
  return ListTile(
    dense: true,
    visualDensity: VisualDensity(horizontal: 4, vertical: -4),
    minLeadingWidth: 0,
    horizontalTitleGap: 4.w,
    contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
    leading: Padding(
      padding: EdgeInsets.only(top: 0.h),
      child: Image.asset(
        assetPath,
        width: 20.w,
        height: 20.h,
        fit: BoxFit.contain,
      ),
    ),
    title: Padding(
      padding: EdgeInsets.only(bottom: 0.h),
      child: Text(
        label,
        style: TextStyle(color: Colors.brown, fontSize: 14.sp, height: 0.9),
      ),
    ),
    onTap: onTap ?? () => Get.back(),
  );
}
