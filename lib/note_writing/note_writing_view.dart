import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'note_writing_controller.dart';

class NoteWritingView extends StatefulWidget {
  @override
  State<NoteWritingView> createState() => _NoteWritingViewState();
}

class _NoteWritingViewState extends State<NoteWritingView> {
  final controller = Get.put(NoteWritingController());

  late TextEditingController titleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: controller.title.value);
    noteController = TextEditingController(text: controller.note.value);
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: SafeArea(
        child: Stack(
          children: [
            // Background birds
            Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 1,
                child: Image.asset('assets/background_bird.png', height: 400.h),
              ),
            ),

            // Main Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_right_alt, color: Colors.white),
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7EA),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(Icons.menu, color: Colors.brown, size: 20.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Editable Title (conditionally visible)
                  Obx(() => controller.isTitleVisible.value
                      ? GestureDetector(
                    onTap: () => controller.isTitleVisible.value = false,
                    child: TextField(
                      controller: titleController,
                      onChanged: (value) => controller.title.value = value,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  )
                      : SizedBox.shrink()),
                  SizedBox(height: 8.h),

                  // Editable Note (conditionally visible)
                  Obx(() => controller.isNoteVisible.value
                      ? Expanded(
                    child: GestureDetector(
                      onTap: () => controller.isNoteVisible.value = false,
                      child: TextField(
                        controller: noteController,
                        onChanged: (value) => controller.note.value = value,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: "Write your note...",
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  )
                      : Expanded(child: SizedBox.shrink())),
                ],
              ),
            ),

            // Bottom Control Panel
            Positioned(
              bottom: -40,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7EA),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Action Icons
                        Row(
                          children: [
                            SizedBox(width: 40.w),
                            Icon(Icons.camera_alt_outlined, color: Colors.brown),
                            SizedBox(width: 40.w),
                            Icon(Icons.edit, color: Colors.brown),
                            SizedBox(width: 40.w),
                            Icon(Icons.link, color: Colors.brown),
                            SizedBox(width: 40.w),
                            Icon(Icons.list, color: Colors.brown),
                          ],
                        ),
                        // Edited Time Info
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() => Text(
                              controller.editedDate.value,
                              style: TextStyle(color: Colors.brown, fontSize: 12.sp),
                            )),
                            SizedBox(width: 16.w),
                            Obx(() => Text(
                              controller.editedTime.value,
                              style: TextStyle(color: Colors.brown, fontSize: 12.sp),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Decorative Bird Overlay
                  Transform.translate(
                    offset: Offset(20.w, -100.h), // Adjust X and Y values as needed
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset('assets/birds_with_tree.png', height: 160.h),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
