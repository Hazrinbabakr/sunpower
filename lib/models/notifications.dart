import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  image,
  product,
  category,
  normal
}


class NotificationModel {

  String uid;
  String title;
  String body;
  NotificationType type;
  String? link;
  DateTime createdAt;

  NotificationModel({
    required this.uid,
    required this.title,
    required this.body,
    required this.type,
    this.link,
    required this.createdAt
  });

  factory NotificationModel.fromDoc(DocumentSnapshot doc){
    return NotificationModel(
        title: doc['title'],
        body: doc['body'],
        createdAt: (doc['created_at'] as Timestamp).toDate(),
        link: (doc.data()! as Map)['link'],
        uid: doc.id,
        type: _getNotificationType(doc['type'])
    );
  }

  static NotificationType _getNotificationType(String type){
    switch (type){
      case 'image':
        return NotificationType.image;
      case 'category':
        return NotificationType.category;
      case 'product':
        return NotificationType.product;
      case 'normal':
        return NotificationType.normal;
      default:
        return NotificationType.normal;

    }
  }

}