import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/models/notifications.dart';

class NotificationProvider extends ChangeNotifier{


  static NotificationProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<NotificationProvider>(context, listen: listen);


  List<NotificationModel>? notifications;
  var lastDoc;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool done = false;
  bool loading = false;
  int page = 1;
  dynamic error;
  final int size = 10;

  getNotifications() async {
    try {
      print("getNotifications");
      if(done){
        return;
      }
      loading = true;
      print("loading");
      var query = _firestore
          .collection("notification")
          .where('active',isEqualTo: true)
          .orderBy("created_at",descending: true)
          .limit(size);
      if(lastDoc != null){
        query = query.startAfterDocument(lastDoc);
      }
      var result = await query.get();

      lastDoc = result.docs.last;

      if(result.size < size){
        done = true;
      }

      if(notifications == null){
        notifications = [];
      }

      notifications!.addAll(
        List<NotificationModel>.from(result.docs.map((e) => NotificationModel.fromDoc(e)))
      );

      loading = false;
      notifyListeners();
    } catch(error) {
      print(error.toString());
      this.error = error;
      loading = false;
      notifyListeners();
    }
  }

  reset() async {
    if(loading) return;
    notifications = null;
    lastDoc = null;
    done = false;
    notifyListeners();
    await getNotifications();
  }
}