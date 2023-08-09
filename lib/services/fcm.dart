
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../data/news/local_database/local_database.dart';
import '../data/news/model/model.dart';
import '../ui/news/widgets/news_provider.dart';
import 'local_notification_service.dart';

Future<void> initFirebase(BuildContext context) async {
  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");
  await FirebaseMessaging.instance.subscribeToTopic("news");

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // FOREGROUND MESSAGE HANDLING.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FOREGROUND MODE: ${message.data["news_image"]} va ${message.notification!.title} in foreground");
    LocalNotificationService.instance.showFlutterNotification(message);
    LocalDatabase.insertNews(NewsModelSql.fromJson(message.data));
    if (context.mounted) context.read<NewsProvider>().readNews();
  });

  // BACkGROUND MESSAGE HANDLING
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FROM TERMINATED MODE

  handleMessage(RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FROM TERMINATED MODE: ${message.data["news_image"]} va ${message.notification!.title} in terminated");
    LocalNotificationService.instance.showFlutterNotification(message);
    LocalDatabase.insertNews(NewsModelSql.fromJson(message.data));
  }

  RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handleMessage(remoteMessage);
    LocalDatabase.insertNews(NewsModelSql.fromJson(remoteMessage.data));
    if (context.mounted) context.read<NewsProvider>().readNews();
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  LocalDatabase.insertNews(NewsModelSql.fromJson(message.data));
  debugPrint(
      "NOTIFICATION BACKGROUND MODE: ${message.data["news_image"]} va ${message.notification!.title} in background");
}