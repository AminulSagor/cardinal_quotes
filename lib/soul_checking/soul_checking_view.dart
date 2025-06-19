import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'soul_checking_controller.dart';

class SoulCheckingView extends StatelessWidget {
  final controller = Get.put(SoulCheckingController());
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> feelings = [
    {'icon': Icons.sentiment_very_satisfied, 'label': 'Awesome'},
    {'icon': Icons.sentiment_satisfied, 'label': 'Good'},
    {'icon': Icons.remove, 'label': 'Neutral'},
    {'icon': Icons.sentiment_dissatisfied, 'label': 'Bad'},
    {'icon': Icons.sentiment_very_dissatisfied, 'label': 'Terrible'},
  ];

  void selectFeeling(String label) {
    controller.selectFeeling(label);

    // Dismiss previous dialog (if open)
    if (Get.isDialogOpen ?? false) Get.back();

    // Show new dialog
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 340,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7EA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, color: Colors.brown),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Share something with us.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9EBD9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: controller.messageController,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: 'I',
                      hintStyle: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.brown,
                          side: BorderSide(color: Colors.brown),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.handleNoteSubmission(),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown.shade400,
                          foregroundColor: Colors.white.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: Center(
        child: Container(
          width: 320.w,
          padding: EdgeInsets.only(
            left: 16.w,
            right: 8.w,
            top: 8.h,
            bottom: 16.h,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7EA),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: Colors.brown),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'How Are You Feeling Today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Wrap(
                spacing: 20.w,
                runSpacing: 16.h,
                alignment: WrapAlignment.center,
                children:
                    feelings.map((item) {
                      return GestureDetector(
                        onTap: () => selectFeeling(item['label']),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item['icon'],
                              color: Colors.brown,
                              size: 20.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              item['label'],
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
