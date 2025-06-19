import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';


class NotificationService {
  static Future<void> scheduleOneTime({
    required int id,
    required String title,
    required DateTime scheduledTime,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Medicine Reminder',
      'Time to take $title',
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'todo_channel',
          'To-Do Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

    print('📅 One-time notification set for $scheduledTime');
  }

  static Future<void> scheduleRepeatSpecificDays({
    required String title,
    required TimeOfDay time,
    required List<int> weekdays, // Sunday = 1, Saturday = 7
  }) async {
    for (int weekday in weekdays) {
      final now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduled = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      // Move to the next matching weekday
      while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
        scheduled = scheduled.add(Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        weekday * 1000 + time.hour * 60 + time.minute, // unique ID
        'Medicine Reminder',
        'Time to take $title',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'todo_channel',
            'To-Do Reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
