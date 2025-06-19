import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../combine_service/notification_service.dart';

class TodoController extends GetxController {
  RxList<Map<String, dynamic>> todos = <Map<String, dynamic>>[].obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);


  RxBool showInput = false.obs;
  RxString newTodo = ''.obs;

  RxBool isRepeat = true.obs;
  RxList<String> selectedDays = <String>[].obs;
  RxString selectedTime = ''.obs;

  final String _storageKey = 'saved_todos';

  @override
  void onInit() {
    super.onInit();
    loadTodosFromStorage();
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  void selectAllDays() {
    selectedDays.assignAll(['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']);
  }


  void toggleTodo(int index) {
    todos[index]['checked'] = !todos[index]['checked'];
    saveTodosToStorage();
    todos.refresh();
  }

  Future<String?> addTodo() async {
    if (newTodo.value.trim().isEmpty) return "Please enter a to-do.";
    if (selectedTime.value.isEmpty) return "Please select a time.";

    if (!isRepeat.value && selectedDate.value == null) {
      return "Please select a date.";
    }

    if (isRepeat.value && selectedDays.isEmpty) {
      return "Please select at least one day.";
    }

    final String timeText;
    if (isRepeat.value) {
      final dayText = selectedDays.length == 7 ? 'Everyday' : 'Every ${selectedDays.join(', ')}';
      timeText = "$dayText at ${selectedTime.value}";
    } else {
      timeText = "One-time on ${formatDate(selectedDate.value!)} at ${selectedTime.value}";
    }



    todos.add({
      "title": newTodo.value.trim(),
      "time": timeText,
      "checked": false,
      "overdue": false,
    });

    await saveTodosToStorage();
    await checkAndPromptExactAlarm();

    // Schedule Notification
    final scheduledTime = parseTime(selectedTime.value);
    final title = newTodo.value.trim();

    if (isRepeat.value) {
      final weekdays = selectedDays.map(mapDayToWeekday).toList();
      NotificationService.scheduleRepeatSpecificDays(
        title: title,
        time: TimeOfDay(hour: scheduledTime.hour, minute: scheduledTime.minute),
        weekdays: weekdays,
      );
    } else {
      final oneTimeDateTime = DateTime(
        selectedDate.value!.year,
        selectedDate.value!.month,
        selectedDate.value!.day,
        scheduledTime.hour,
        scheduledTime.minute,
      );

      NotificationService.scheduleOneTime(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: title,
        scheduledTime: oneTimeDateTime,
      );
    }


    // Reset inputs
    newTodo.value = '';
    selectedTime.value = '';
    selectedDays.clear();
    selectedDate.value = null;
    showInput.value = false;

    return null; // Success
  }



  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  Future<void> saveTodosToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(todos);
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> loadTodosFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_storageKey);
    if (saved != null) {
      final decoded = jsonDecode(saved) as List;
      todos.value = decoded.cast<Map<String, dynamic>>();
    }
  }

  DateTime parseTime(String timeStr) {
    final parts = timeStr.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(" ")[0]);
    final isPM = timeStr.toLowerCase().contains("pm");
    final adjustedHour = (isPM && hour < 12) ? hour + 12 : (hour == 12 && !isPM) ? 0 : hour;
    return DateTime(0, 1, 1, adjustedHour, minute);
  }

  int mapDayToWeekday(String day) {
    const mapping = {
      'Sun': DateTime.sunday,
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
    };
    return mapping[day]!;
  }

  Future<void> checkAndPromptExactAlarm() async {
    const platform = MethodChannel('alarm.settings');

    try {
      final bool isExactAlarmAllowed = await platform.invokeMethod('checkExactAlarmPermission');
      if (!isExactAlarmAllowed) {
        await platform.invokeMethod('openExactAlarmSettings');
      }
    } on PlatformException catch (e) {
      debugPrint("Exact Alarm setting failed: ${e.message}");
    }
  }



}
