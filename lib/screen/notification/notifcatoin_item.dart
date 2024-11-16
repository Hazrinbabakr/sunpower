import 'package:flutter/material.dart';
import 'package:sunpower/models/notifications.dart';
import 'package:sunpower/screen/productDetails.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const NotificationItem({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(notification.type == NotificationType.product){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetails(notification.link!)));
        }
        else if (notification.type == NotificationType.category){

        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.7,
              spreadRadius: 0.9
            )
          ]
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black87,fontSize: 14),
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    notification.body,
                    style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black54,fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            if(notification.link!= null && notification.type == NotificationType.image)
              AspectRatio(
                aspectRatio: 1.7,
                child: Image.network(notification.link!, fit: BoxFit.cover,),
              )
          ],
        ),
      ),
    );
  }
}
