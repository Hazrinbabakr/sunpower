import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  showNotification(RemoteMessage msg) async {
    var android = new AndroidNotificationDetails(
      "1",
      "AutoTruck",
      icon: "logo_icon",
      channelDescription: "AutoTruckStore general notification",
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
      print("lutterLocalNotificationsPlugin.show");
      await flutterLocalNotificationsPlugin.show(
          0,
          (msg.notification?.title??""),
          (msg.notification?.body??""),
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

    //if (Platform.isIOS)

    askForPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print("FirebaseMessaging.onMessage");
      showNotification(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

    });
    sendFCMToken();
    //_firebaseMessaging.subscribeToTopic("general");
  }

  void askForPermission() async  {
    print("iOS_Permission");
    var res = await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    print(res);
  }
  
  sendFCMToken() async {
    await FirebaseMessaging.instance.subscribeToTopic('general');
    String? token = await FirebaseMessaging.instance.getToken();

    if(token != null){
      if(FirebaseAuth.instance.currentUser != null){
        print(FirebaseAuth.instance.currentUser!.uid);
        var doc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
        doc.update({
          'fcmToken':token
        });
      }
    }
  }
}

final notificationHelper = NotificationHelper();