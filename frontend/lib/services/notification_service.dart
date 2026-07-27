import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'core_daily';
  static const _channelName = 'Daily Reminder';
  static const _notifId = 1;
  static const _prefEnabled = 'notif_enabled';
  static const _prefHour = 'notif_hour';
  static const _prefMinute = 'notif_minute';

  // ── Rotating daily prompts ────────────────────────────────────────────────

  static const _prompts = [
    'What is one belief you hold that you have never truly examined?',
    'Describe a moment today where you chose comfort over courage.',
    'What would your ideal self have done differently today?',
    'What are you most resistant to right now — and why?',
    'Where did you give away your agency today?',
    'What are you pretending not to know?',
    'What would you do if you knew it would fail?',
  ];

  String get _todayPrompt {
    final day = DateTime.now().weekday - 1;
    return _prompts[day % _prompts.length];
  }

  // ── Initialise ────────────────────────────────────────────────────────────

  Future<void> init() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    // Re-schedule if was already enabled (survives app restarts)
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_prefEnabled) ?? false;
    if (enabled) {
      final hour = prefs.getInt(_prefHour) ?? 8;
      final minute = prefs.getInt(_prefMinute) ?? 0;
      await _schedule(TimeOfDay(hour: hour, minute: minute));
    }
  }

  // ── Permission ────────────────────────────────────────────────────────────

  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    bool granted = true;

    if (android != null) {
      granted = await android.requestNotificationsPermission() ?? false;
    }
    if (ios != null) {
      granted = await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return granted;
  }

  // ── Schedule daily notification ───────────────────────────────────────────

  Future<void> enable(TimeOfDay time) async {
    final granted = await requestPermission();
    if (!granted) return;

    await _schedule(time);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefEnabled, true);
    await prefs.setInt(_prefHour, time.hour);
    await prefs.setInt(_prefMinute, time.minute);
  }

  Future<void> disable() async {
    await _plugin.cancel(_notifId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefEnabled, false);
  }

  Future<void> _schedule(TimeOfDay time) async {
    await _plugin.cancel(_notifId);

    final now = DateTime.now();
    var scheduled =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // If today's time has already passed, schedule for tomorrow
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    // Create combined notification details
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      ),
    );

    await _plugin.zonedSchedule(
      _notifId,
      'CORE — Daily Reflection',
      _todayPrompt,
      tz.TZDateTime.from(scheduled, tz.local),
      notificationDetails, // ← fixed: use combined details
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeats daily
    );
  }

  // ── Saved settings helpers ────────────────────────────────────────────────

  Future<bool> isEnabled() async =>
      (await SharedPreferences.getInstance()).getBool(_prefEnabled) ?? false;

  Future<TimeOfDay> savedTime() async {
    final prefs = await SharedPreferences.getInstance();
    return TimeOfDay(
      hour: prefs.getInt(_prefHour) ?? 8,
      minute: prefs.getInt(_prefMinute) ?? 0,
    );
  }
}
