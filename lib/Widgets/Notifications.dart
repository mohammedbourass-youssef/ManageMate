import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Widgets/NotificationHEader.dart';
import 'package:teamtasks/Widgets/NotifyMessage.dart';
import 'package:teamtasks/models/NotficationModal.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Notificationservice.getallnotifications(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Text(
              'Sorry , try again',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'You have no notifiactions',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
        return Column(
          children: [
            SizedBox(height: 25),
            Notificationheader(),
            Divider(color: Color(kSecondaryColor)),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Notifymessage(
                    notify: Notficationmodal.fromData(
                      snapshot.data!.docs[index],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
