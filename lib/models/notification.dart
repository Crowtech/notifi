class CrowtechNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final String? userId;

  CrowtechNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.userId,
  });

  factory CrowtechNotification.fromJson(Map<String, dynamic> json) {
    return CrowtechNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.info,
      ),
      isRead: json['isRead'] as bool? ?? false,
      userId: json['userId'] as String?,
    );
  }
}

enum NotificationType {
  info,
  warning,
  error,
  success,
  memberUpdate,
  locationUpdate
}
