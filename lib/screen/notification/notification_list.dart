import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/models/notifications.dart';
import 'package:sunpower/screen/notification/notificatoin_provider.dart';

import 'notifcatoin_item.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({Key? key}) : super(key: key);

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {

  NotificationProvider _notificationProvider = NotificationProvider();

  @override
  void initState() {
    super.initState();
    _notificationProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _notificationProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).trans("notifications")),
        ),
        body: Consumer<NotificationProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if(value.notifications == null){
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                ),
              );
            }
            if(value.notifications!.isEmpty){
              return Center(
                child: Container(),
              );
            }
            List<NotificationModel> notifications = value.notifications!;
            return RefreshIndicator(
              onRefresh: () async {
                await NotificationProvider.of(context).reset();
              },
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16
                ),
                itemCount: notifications.length + 1,
                itemBuilder: (context,index){
                  if(index == notifications.length){
                    NotificationProvider.of(context).getNotifications();
                    return const SizedBox();
                  }
                  return NotificationItem(
                    notification: notifications[index],
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 8,);
                },
              ),
            );

          },
        ),
      ),
    );
  }
}
