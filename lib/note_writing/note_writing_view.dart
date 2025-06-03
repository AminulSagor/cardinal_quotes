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

    titleController.addListener(() {
      controller.title.value = titleController.text;
    });
    noteController.addListener(() {
      controller.note.value = noteController.text;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          await Future.delayed(const Duration(milliseconds: 200));
        }

        controller.saveOrUpdateNote();
        await Future.delayed(const Duration(milliseconds: 200));
        Future.microtask(() => Get.back()); // Navigate immediately

        return false;
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/note_writing_back.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.arrow_right_alt, color: Colors.brown),
                        ),

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
                    SizedBox(height: 20.h),

                    // Title input
                    Obx(() => controller.isTitleVisible.value
                        ? TextField(
                      controller: titleController,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    )
                        : SizedBox.shrink()),
                    SizedBox(height: 20.h),

                    // Note input
                    Obx(() => controller.isNoteVisible.value
                        ? Expanded(
                      child: TextField(
                        controller: noteController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: "Note",
                          hintStyle: TextStyle(
                            color: Colors.brown.withOpacity(0.4),
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    )
                        : Expanded(child: SizedBox.shrink())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
