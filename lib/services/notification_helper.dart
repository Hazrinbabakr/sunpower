import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  String token;

  showNotification(Map<String, dynamic> remoteMessage) async {
    print("msg : $remoteMessage");
    var android = new AndroidNotificationDetails(
      CHANNEL_NAME,
      "Zagros channel",
      "Zagros notifications channel",
      styleInformation: BigTextStyleInformation(''),
    );
    var ios = new IOSNotificationDetails(
      sound: "not_1",
      presentSound: true,
    );
    var platform = new NotificationDetails(android: android, iOS: ios);
//    //printmsg['notification']['body']);
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .show(
            0,
            (remoteMessage["title"]),
            (remoteMessage["body"]),
            platform,
            //payload: json.encode(remoteMessage.data ?? {}),
          )
          .then((val) {})
          .catchError((e) {
        //print"error " + e.toString());
      });
    }

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.show(
          0,
          (remoteMessage["title"]),
          (remoteMessage['body']),
          platform,
          //payload: json.encode(remoteMessage.data ?? {})
      );
    }
  }

  void firebaseCloudMessagingListeners(/*BuildContext context*/) {
    //print('firebaseCloudMessaging_Listeners');

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('logo');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(
      android: android,
      iOS: ios,
    );
    flutterLocalNotificationsPlugin
        .initialize(platform)
        .then((v) {

    });

    if (!kReleaseMode) {
      _firebaseMessaging.subscribeToTopic("debug2").then((value) {});
    }

    if (Platform.isIOS) {
      iOS_Permission();
    }

    if (Platform.isAndroid) {
      _createNewChannel();
    }

    _firebaseMessaging.configure(
      onMessage: (message) {
        return showNotification(message);
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
  }

  static const String CHANNEL_NAME = "zagros_notifications_channel";

  void _createNewChannel() async {
    try {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        CHANNEL_NAME, // id
        'Push Notification Channel', // title
        'This channel is used for push notification.', // description
        importance: Importance.max,
        playSound: true,
      );
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } on PlatformException catch (e) {
      //print(e);
    }
  }
}

final notificationHelper = NotificationHelper();