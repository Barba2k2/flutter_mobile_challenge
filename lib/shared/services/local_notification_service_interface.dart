abstract class LocalNotificationServiceInterface {
  Future<void> initialize();
  Future<void> showNotification({
    required String title,
    required String body,
  });
}
