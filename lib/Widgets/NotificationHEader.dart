import 'package:flutter/material.dart';
import 'package:teamtasks/Services/NotificationService.dart';

class Notificationheader extends StatefulWidget {
  const Notificationheader({super.key});

  @override
  State<Notificationheader> createState() => _NotificationheaderState();
}

class _NotificationheaderState extends State<Notificationheader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Notificationservice.countTotalUnseenNotifications(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Text(
            'Loading ...',
            style: TextStyle(color: Colors.deepPurple, fontSize: 20),
          );
        }
        return Row(
          children: [
            SizedBox(width: 30),
            Icon(Icons.notifications, color: Colors.deepPurple, size: 30),
            SizedBox(width: 10),
            Text(
              'Notifications',
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            SizedBox(width: 10),
            (snapshot.hasData)
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      snapshot.data.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
