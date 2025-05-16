import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';

class TodoView extends StatelessWidget {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),
                Row(
                  children: [
                    Icon(Icons.arrow_right_alt, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      "To-dos",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Todo List
                Obx(
                  () => Column(
                    children:
                        controller.todos
                            .asMap()
                            .entries
                            .map(
                              (entry) => _buildTodoTile(entry.key, entry.value),
                            )
                            .toList(),
                  ),
                ),
                const Spacer(),

                // Bird Image
                Transform.translate(
                  offset: Offset(0, 15.h), // Move up by 10 logical pixels (adjust as needed)
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset('assets/two_bird.png', height: 180.h),
                  ),
                ),

              ],
            ),
          ),

          // Floating Add Button
          Obx(() {
            if (!controller.showInput.value) {
              return Positioned(
                bottom: 40.h,
                right: 40.w,
                child: GestureDetector(
                  onTap: () => controller.showInput.value = true,
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
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Image.asset('assets/floating_button_plus.png'),
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          }),


          // Bottom Input
          Obx(() {
            if (!controller.showInput.value) return SizedBox.shrink();
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7EA),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.showInput.value = false,
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "New To-dos",
                          style: TextStyle(
                            color: const Color(0xFF591A0E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: controller.addTodo,
                          child: Text(
                            "Save",
                            style: TextStyle(color: const Color(0xFF591A0E),fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF591A0E),
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 4),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        onChanged: (value) => controller.newTodo.value = value,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'New To-dos',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTodoTile(int index, Map<String, dynamic> todo) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EA),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.toggleTodo(index),
            child: Icon(
              todo['checked']
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: todo['checked'] ? Colors.brown : Colors.grey,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              todo['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: todo['checked'] ? Colors.brown : Colors.black,
              ),
            ),
          ),
          Text(
            todo['time'],
            style: TextStyle(
              color: todo['overdue'] ? Colors.red : Colors.black54,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
