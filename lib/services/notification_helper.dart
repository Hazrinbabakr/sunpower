import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  showNotification(RemoteMessage msg) async {
    var android = new AndroidNotificationDetails(
      "1",
      "Channel Name",
      channelDescription: "Channel description",
      styleInformation: BigTextStyleInformation(''),
    );
    var ios = new DarwinNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
//    print(msg['notification']['body']);
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin.show(
        0,
        (msg.notification?.title??""),
        (msg.notification?.body??""),
        platform,
      );
    }

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.show(
          0,
          (msg.notification?.title??""),
          (msg.notification?.title??""),
          platform,
          payload: '');
    }
  }

  void firebaseCloudMessaging_Listeners(/*BuildContext context*/) async {
    print('firebaseCloudMessaging_Listeners');
    //await Firebase.initializeApp();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new DarwinInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform).then((v) {
      //showNotification(message);
    });

    if (Platform.isIOS) iOS_Permission();

    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

    });
    _firebaseMessaging.subscribeToTopic("general");
  }

  void iOS_Permission() {
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
  }
}

final notificationHelper = NotificationHelper();
