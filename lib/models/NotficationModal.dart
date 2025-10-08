import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Services/NotificationService.dart';

class Notficationmodal {
  String iD;
  String senderID;
  String senderName;
  String receiverID;
  String recievrname;
  String projectID;
  String projectName;
  String projectGithub;
  int type;
  bool seen;
  DateTime createdAt;
  String message;
  Notficationmodal({
    required this.iD,
    required this.type,
    required this.projectID,
    required this.receiverID,
    required this.seen,
    required this.senderID,
    required this.createdAt,
    required this.recievrname,
    required this.projectName,
    required this.senderName,
    required this.message,
    required this.projectGithub,
  });
  factory Notficationmodal.fromData(data) {
    Timestamp ts = data[Notificationservice.kCreatedAt];
    return Notficationmodal(
      createdAt: ts.toDate(),
      type: data[Notificationservice.kType],
      iD: data[Notificationservice.kID],
      projectID: data[Notificationservice.kProjctID],
      receiverID: data[Notificationservice.kToUserID],
      seen: data[Notificationservice.kIsRead],
      senderID: data[Notificationservice.kFromUserID],
      projectName: data[Notificationservice.kProjectName],
      recievrname: data[Notificationservice.kReceiverName],
      senderName: data[Notificationservice.kSenderName],
      message: data[Notificationservice.kMessage],
      projectGithub: data[Notificationservice.kgithub],
    );
  }
}
