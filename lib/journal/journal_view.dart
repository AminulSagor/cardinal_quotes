import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../note_writing/note_writing_view.dart';
import 'journal_controller.dart';

class JournalView extends StatelessWidget {
  final controller = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_right_alt, color: Colors.white),
                          SizedBox(width: 4.w),
                          Text(
                            "Sacred Journals",
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: controller.toggleSearch,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7EA),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(Icons.search, color: Colors.brown, size: 20.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Obx(() => controller.isSearchVisible.value
                      ? Column(
                    children: [
                      TextField(
                        onChanged: controller.search,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFFFF7EA),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                          hintText: "Search notes...",
                          hintStyle: TextStyle(color: Colors.brown.withOpacity(0.6)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.brown),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close, color: Colors.brown),
                            onPressed: controller.toggleSearch,
                          ),
                        ),
                        style: TextStyle(color: Colors.brown),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  )
                      : SizedBox.shrink()),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator(color: Colors.white));
                      }

                      final journals = controller.filteredJournals;
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 160.h),
                        itemCount: journals.length,
                        itemBuilder: (context, index) {
                          final journal = journals[index];
                          final color = journal['color'] as int;
                          final isDark = color == 0xFF000000;

                          return GestureDetector(
                            onTap: () async {
                              await Get.to(() => NoteWritingView(), arguments: {
                                "id": journal["id"],
                                "title": journal["title"],
                                "note": journal["text"],
                              });
                              controller.loadJournals();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Color(color),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        journal["title"] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? Colors.white : Colors.brown,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      journal["text"] as String,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: isDark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset('assets/two_bird.png', height: 180.h),
            ),
            Positioned(
              bottom: 40.h,
              right: 40.w,
              child: GestureDetector(
                onTap: () async {
                  await Get.to(() => NoteWritingView());
                  controller.loadJournals();
                },
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7EA),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/floating_button_plus.png',
                      width: 28.w,
                      height: 28.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
