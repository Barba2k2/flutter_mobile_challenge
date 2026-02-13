import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification_service_interface.dart';

class LocalNotificationService implements LocalNotificationServiceInterface {
  final FlutterLocalNotificationsPlugin _plugin;

  LocalNotificationService({
    FlutterLocalNotificationsPlugin? plugin,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );
    await _plugin.initialize(settings: initSettings);
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'Default notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );
    const darwinDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}
