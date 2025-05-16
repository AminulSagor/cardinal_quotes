import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7EA),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(Icons.search, color: Colors.brown, size: 20.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: Obx(() {
                      final journals = controller.journals;
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 160.h),
                        itemCount: journals.length,
                        itemBuilder: (context, index) {
                          final journal = journals[index];

                          // Full width for index 2
                          if (index == 2) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Color(journal['color'] as int),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        journal["title"] as String,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),

                                       Text(
                                        journal["text"] as String,
                                         textAlign: TextAlign.center,

                                         style: TextStyle(fontSize: 12.sp),
                                      ),

                                    SizedBox(height: 6.h),
                                    Center(child: const Text("..........")),
                                  ],
                                ),
                              ),
                            );
                          }

                          // Other items in 2-column grid style
                          return Row(
                            children: [
                              if (index % 2 == 0 && index != 2) ...[
                                _buildGridCard(journals[index]),
                                SizedBox(width: 12.w),
                                if (index + 1 < journals.length && index + 1 != 2)
                                  _buildGridCard(journals[index + 1])
                                else
                                  Expanded(child: SizedBox()), // filler if odd count
                              ],
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Bird Image
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset('assets/two_bird.png', height: 180.h),
            ),

            // Floating add button
            // Floating add button
            Positioned(
              bottom: 40.h,
              right: 40.w,
              child: GestureDetector(
                onTap: () {
                  // Handle button tap here
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

  Widget _buildGridCard(Map<String, dynamic> journal) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Color(journal['color'] as int),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                journal["title"] as String,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              journal["text"] as String,
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 12.sp),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            Center(child: const Text("..........")),
          ],
        ),
      ),
    );
  }
}
