import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Taskservices {
  static const kTasksCollections = 'ProjectTasks';
  static const kTaskID = 'ID';
  static const kStutus = 'TaskState';
  static const kprojectID = 'projectID';
  static const kprojectName = 'projectname';
  static const kprojectGithub = 'projectGithub';
  static const kAdmin = 'AdminName';
  static const kAdminID = 'AdminID';
  static const kCollaboratorID = 'userID';
  static const kCollaboratorName = 'userName';
  static const kCreatedAt = 'CreatedAt';
  static const kLastDate = 'EndDate';

  static Future<void> addTask(Taskmodal task) async {
    var doc = await FirebaseFirestore.instance
        .collection(kTasksCollections)
        .add(task.toJson());
    await doc.update({kTaskID: doc.id});
    await Colaboratorservice.increaseTheStatisticsByOne(task.collaboratorId);
    await Projectsservice.changeprojectRuningTaks(task.projectId, 1);
  }

  static Stream<QuerySnapshot> getProjectsAllTasks(String projectID) {
    var query = FirebaseFirestore.instance
        .collection(kTasksCollections)
        .where(kprojectID, isEqualTo: projectID)
        .orderBy(kStutus);
    return query.snapshots();
  }

  static Stream<QuerySnapshot> getProjectsAllTasksForThisUSer(
    String projectID,
  ) {
    var query = FirebaseFirestore.instance
        .collection(kTasksCollections)
        .where(kprojectID, isEqualTo: projectID)
        .where(kCollaboratorID, isEqualTo: logedinUser!.id)
        .orderBy(kStutus);
    return query.snapshots();
  }

  static Stream<int> userComleteTasksCountStream() {
    return FirebaseFirestore.instance
        .collection(kTasksCollections)
        .where(kCollaboratorID, isEqualTo: logedinUser!.id)
        .where(kStutus, isEqualTo: EnTaskSatate.verified.index)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Stream<QuerySnapshot> getCurrentUSerTasks(String name) {
    var query = FirebaseFirestore.instance
        .collection(kTasksCollections)
        .where(kCollaboratorID, isEqualTo: logedinUser!.id)
        .where(kprojectName, isGreaterThanOrEqualTo: name)
        .where(
          kprojectName,
          isLessThan: '$name\uf8ff',
        ); // replace with kProjectName
    return query.snapshots();
  }

  static Future<void> changeTaskStatus(String name, int newstatus) async {
    FirebaseFirestore.instance.collection(kTasksCollections).doc(name).update({
      kStutus: newstatus,
    });
  }
}

enum EnTaskSatate { fresh, refused, inprocessus, complited, verified }
