import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';

class TodoView extends StatelessWidget {
  final controller = Get.put(TodoController());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAA4A2E),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),

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
                SizedBox(height: 8.h),

                // Todo List
                Obx(
                      () => Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: controller.todos
                            .asMap()
                            .entries
                            .map((entry) => _buildTodoTile(entry.key, entry.value))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 100.h), // for spacing above the bird image


                // Bird Image


              ],
            ),
            // Bird Image - ✅ Correct place


          ),
          Positioned(
            bottom: 15,
            left: 0,
            child: Transform.translate(
              offset: Offset(0, 15.h),
              child: Image.asset('assets/two_bird.png', height: 180.h),
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
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => controller.showInput.value = false,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: const Color(0xFF591A0E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "New To-dos",
                            style: TextStyle(
                              color: const Color(0xFF591A0E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              final error = await controller.addTodo();
                              if (error != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                              } else {
                                textController.clear(); // ✅ Clear the input
                                controller.newTodo.value = ''; // Also reset the observable
                                controller.showInput.value = false; // Optional: close input panel
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("To-do saved successfully."),
                                  ),
                                );
                              }
                            },


                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: const Color(0xFF591A0E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      // Step 1: Text input
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
                          controller: textController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                          ],
                          onChanged: (value) {
                            controller.newTodo.value = value;
                            if (value.length == 30) {
                              Get.snackbar(
                                "Limit Reached",
                                "Maximum 30 characters allowed.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.shade100,
                                colorText: Colors.black,
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                              );
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'New To-dos',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Step 2: Ask repeat or one-time
                      if (controller.newTodo.value.isNotEmpty)
                        Column(
                          children: [
                            Text(
                              "Is it repetitive?",
                              style: TextStyle(color: Colors.brown),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ChoiceChip(
                                  label: Text("Yes"),
                                  selected: controller.isRepeat.value,
                                  onSelected:
                                      (_) => controller.isRepeat.value = true,
                                ),
                                SizedBox(width: 8),
                                ChoiceChip(
                                  label: Text("No"),
                                  selected: !controller.isRepeat.value,
                                  onSelected:
                                      (_) => controller.isRepeat.value = false,
                                ),
                              ],
                            ),
                            if (controller.isRepeat.value) ...[
                              TextButton(
                                onPressed: () => controller.selectAllDays(),
                                child: const Text("Select All Days"),
                              ),
                              Wrap(
                                spacing: 6.w,
                                runSpacing: 6.h,
                                children: [
                                  'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
                                ].map((day) => Obx(() {
                                  final isSelected = controller.selectedDays.contains(day);
                                  return ChoiceChip(
                                    label: Text(day),
                                    selected: isSelected,
                                    selectedColor: Colors.brown,
                                    backgroundColor: Colors.grey.shade200,
                                    labelStyle: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                    onSelected: (_) => controller.toggleDay(day),
                                  );
                                })).toList(),
                              ),
                            ],


                            // Step 3: Time picker
                            TextButton(
                              onPressed: () async {
                                if (!controller.isRepeat.value) {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    controller.selectedDate.value = pickedDate;
                                  }
                                }

                                final pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  controller.selectedTime.value = pickedTime
                                      .format(context);
                                }
                              },
                              child: Obx(() {
                                final hasTime =
                                    controller.selectedTime.value.isNotEmpty;
                                final hasDate =
                                    controller.selectedDate.value != null;
                                final isRepeat = controller.isRepeat.value;

                                String buttonText;

                                if (isRepeat) {
                                  buttonText =
                                      hasTime
                                          ? "Time: ${controller.selectedTime.value}"
                                          : "Pick Time";
                                } else {
                                  if (!hasDate && !hasTime) {
                                    buttonText = "Pick Time & Date";
                                  } else {
                                    buttonText = [
                                      if (hasDate)
                                        "Date: ${controller.formatDate(controller.selectedDate.value!)}",
                                      if (hasTime)
                                        "Time: ${controller.selectedTime.value}",
                                    ].join(" | ");
                                  }
                                }

                                return Text(buttonText);
                              }),
                            ),

                            SizedBox(height: 10.h),
                          ],
                        ),
                    ],
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTodoTile(int index, Map<String, dynamic> todo) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EA),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            todo['title'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: todo['checked'] ? Colors.brown : Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ((todo['days'] ?? '').isNotEmpty)
                Text(
                  todo['days'],
                  style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                ),
              if ((todo['days'] ?? '').isNotEmpty &&
                  todo['time'].toString().isNotEmpty)
                Text("  |  ", style: TextStyle(color: Colors.grey)),
              if ((todo['time'] ?? '').isNotEmpty)
                Text(
                  todo['time'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: todo['overdue'] ? Colors.red : Colors.black45,
                  ),
                ),
            ],
          ),
        ],
      ),

    );
  }
}
