import 'package:firebase_note/notification_services.dart';
import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  NotificationServices notificationServices =NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.intialiseNotifictionns();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          notificationServices.sendNotification(title: "This is First Notification", body: "This notification Body");
        }, child: Text("Send Notification")),
      ),
    );
  }
}
