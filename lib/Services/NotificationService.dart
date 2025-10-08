import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/models/NotficationModal.dart';

class Notificationservice {
  static const kNotifictionCollection = 'NotificationData';
  static const kID = 'ID';
  static const kFromUserID = 'SenderID';
  static const kSenderName = 'SenderName';
  static const kToUserID = 'ReceiverID';
  static const kReceiverName = 'ReceiverName';
  static const kProjctID = 'ProjectID';
  static const kType = 'NotifyType';
  static const kIsRead = 'Seen';
  static const kCreatedAt = 'CreatedAt';
  static const kProjectName = 'projectnama';
  static const kMessage = 'NotifyMessage';
  static const kgithub = 'github';
  static Stream<int> countTotalUnseenNotifications() {
    return FirebaseFirestore.instance
        .collection(kNotifictionCollection)
        .where(kToUserID, isEqualTo: logedinUser?.id)
        .where(kIsRead, isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Stream<QuerySnapshot> getallnotifications() {
    return FirebaseFirestore.instance
        .collection(kNotifictionCollection)
        .where(kToUserID, isEqualTo: logedinUser?.id)
        .orderBy(kCreatedAt, descending: true)
        .limit(100) // 👈 only unseen
        .snapshots();
  }

  static void markAsSeen(id) {
    FirebaseFirestore.instance
        .collection(kNotifictionCollection)
        .doc(id)
        .update({kIsRead: true});
  }

  static Future<void> sendNotifications(Notficationmodal notify) async {
    var doc = await FirebaseFirestore.instance
        .collection(kNotifictionCollection)
        .add({
          kID: 'rdftgyhuji',
          kFromUserID: notify.senderID,
          kCreatedAt: DateTime.now(),
          kIsRead: false,
          kMessage: notify.message,
          kProjctID: notify.projectID,
          kProjectName: notify.projectName,
          kSenderName: notify.senderName,
          kToUserID: notify.receiverID,
          kReceiverName: notify.recievrname,
          kType: notify.type,
          kgithub: notify.projectGithub,
        });
    await doc.update({kID: doc.id});
  }
}

enum EnNotifyType { information, sendinvitation, newtask }

List<String> messages = [
  'invited you to',
  'Accepted your invitation to',
  'refuse your invitation to ',
  'Assigns you a new task',
  'Accepted your task in ',
  'comlited his task in ',
  'verified your task in',
  'has finished the project'
];
