import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Services/UsersServices.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';
import 'package:teamtasks/models/NotficationModal.dart';
import 'package:teamtasks/models/ProjectModal.dart';

class Projectsservice {
  static const String kID = 'ProjectID';
  static const String kProjectsCollection = 'Projects';
  static const String kProjectName = 'Name';
  static const String kGithubLink = 'Github';
  static const String kAdmin = 'CreatedBy';
  static const String kCreatedDatefeild = 'CreatedAt';
  static const String kStatus = 'Status';
  static const String kAdminName = 'NAmeOfTheAdmin';
  static const String kIsAdmin = 'Admin';
  static const String kRunningTasks = 'RuningTasks';
  static Future<void> AddProject(Projectmodal projectinfo) async {
    var doc = await FirebaseFirestore.instance
        .collection(kProjectsCollection)
        .add({
          kID: 'fir',
          kProjectName: projectinfo.projectName,
          kGithubLink: projectinfo.githubLink,
          kAdmin: projectinfo.adminID,
          kAdminName: projectinfo.adminName,
          kCreatedDatefeild: DateTime.now(),
          kStatus: EnProjectStatus.fresh.index,
          kRunningTasks: 0,
        });
    await doc.update({kID: doc.id});
    await Colaboratorservice.addProjectCollaborator(
      Collaboratormodal(
        collaborator: projectinfo.adminID,
        collaboratorName: projectinfo.adminName,
        createdDate: DateTime.now(),
        iD: 'am',
        projectID: doc.id,
        statisticsNumberOfTasks: 0,
        isAdmin: true,
        projectName: projectinfo.projectName,
        projectgithub: projectinfo.githubLink,
      ),
    );
    await Usersservices.increaseTheStatisticsByOne(projectinfo.adminID);
  }

  static Future<void> changeProjectStatus(String name, int newstatus) async {
    FirebaseFirestore.instance.collection(kProjectsCollection).doc(name).update(
      {kStatus: newstatus},
    );
  }

  static Future<void> changeprojectRuningTaks(String name, int number) async {
    FirebaseFirestore.instance.collection(kProjectsCollection).doc(name).update(
      {kRunningTasks: FieldValue.increment(number)},
    );
  }

  static Stream<int> userProjectsCountStream() {
    return FirebaseFirestore.instance
        .collection(kProjectsCollection)
        .where(kAdmin, isEqualTo: logedinUser!.id)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Stream<int> platformPojectsCountStream() {
    return FirebaseFirestore.instance
        .collection(kProjectsCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Stream<QuerySnapshot> getAllProjects(String name) {
    var query = FirebaseFirestore.instance
        .collection(kProjectsCollection)
        .where(kAdmin, isEqualTo: logedinUser!.id)
        .where(kProjectName, isGreaterThanOrEqualTo: name)
        .where(
          kProjectName,
          isLessThan: '$name\uf8ff',
        ); // replace with kProjectName
    return query.snapshots();
  }

  static Future<bool> isThisNameToken(String name, String userID) async {
    var data = await FirebaseFirestore.instance
        .collection(kProjectsCollection)
        .where(kProjectName, isEqualTo: name)
        .where(kAdmin, isEqualTo: userID)
        .get();
    return data.docs.isNotEmpty;
  }

  static Future<void> endTheProject(Projectmodal project) async {
    var collaborators =
        await Colaboratorservice.getAllProjectsCollaboratorsAsList(project.iD);

    for (var item in collaborators) {
      await Notificationservice.sendNotifications(
        Notficationmodal(
          iD: 'nm',
          type: EnNotifyType.information.index,
          projectID: project.iD,
          receiverID: item.collaborator,
          seen: false,
          senderID: logedinUser!.id,
          createdAt: DateTime.now(),
          recievrname: item.collaboratorName,
          projectName: project.projectName,
          senderName: '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
          message: messages[7],
          projectGithub: project.githubLink,
        ),
      );
    }
    await changeProjectStatus(project.iD, EnProjectStatus.comlited.index);
  }
}

enum EnProjectStatus { fresh, cancel, inprogress, comlited }
