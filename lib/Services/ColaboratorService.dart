import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';

class Colaboratorservice {
  static const kCollaboratorsCollections = 'ProjectCollaborators';
  static const kID = 'CollaborationID';
  static const kProjectID = 'ProjectID';
  static const kCollaborator = 'UserID';
  static const kCreatedDate = 'CreatedAt';
  static const kStatisticsNumberOfTasks = 'CountTasks';
  static const kCollaboratorNAme = 'CollaboratorName';
  static const kIsAdmin = 'IsAdmin';
  static const kprojectName = 'projectName';
  static const kprojectGithub = 'github';
  static Future<void> addProjectCollaborator(Collaboratormodal coll) async {
    var doc = await FirebaseFirestore.instance
        .collection(kCollaboratorsCollections)
        .add({
          kProjectID: coll.projectID,
          kCollaborator: coll.collaborator,
          kCollaboratorNAme: coll.collaboratorName,
          kCreatedDate: coll.createdDate,
          kStatisticsNumberOfTasks: coll.statisticsNumberOfTasks,
          kIsAdmin: coll.isAdmin,
          kprojectGithub: coll.projectgithub,
          kprojectName: coll.projectName,
        });
    await doc.update({kID: doc.id});
  }

  static Future<bool> isAlreadyAnCollaborator(
    String id,
    String projectID,
  ) async {
    var query = await FirebaseFirestore.instance
        .collection(kCollaboratorsCollections)
        .where(kCollaborator, isEqualTo: id)
        .where(kProjectID, isEqualTo: projectID)
        .get();
    return query.docs.isNotEmpty;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getCollaborationOfAnID(
    id,
  ) async {
    return FirebaseFirestore.instance
        .collection(kCollaboratorsCollections)
        .where(kCollaborator, isEqualTo: id)
        .get();
  }

  static Future<void> increaseTheStatisticsByOne(String userID) async {
    // Query the user by ID
    var data = await FirebaseFirestore.instance
        .collection(kCollaboratorsCollections)
        .where(kCollaborator, isEqualTo: userID)
        .limit(1)
        .get();

    if (data.docs.isNotEmpty) {
      // get the document ID
      String docId = data.docs.first.id;

      // increment the field
      await FirebaseFirestore.instance
          .collection(kCollaboratorsCollections)
          .doc(docId)
          .update({kStatisticsNumberOfTasks: FieldValue.increment(1)});
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getMyCollaboration(
    String name,
  ) {
    return FirebaseFirestore.instance
        .collection(kCollaboratorsCollections)
        .where(kCollaborator, isEqualTo: logedinUser!.id)
        .get();
  }

  static Stream<QuerySnapshot> getAllProjectsCollaborators(
    String projectID,
    String name,
  ) {
    var query = FirebaseFirestore.instance
        .collection(kCollaboratorsCollections)
        .where(kProjectID, isEqualTo: projectID)
        .where(kCollaboratorNAme, isGreaterThanOrEqualTo: name)
        .where(
          kCollaboratorNAme,
          isLessThan: '$name\uf8ff',
        ); // replace with kProjectName
    return query.snapshots();
  }
  static Stream<int> userCollaborationsCountStream() {
  return FirebaseFirestore.instance
      .collection(kCollaboratorsCollections)
      .where(kCollaborator, isEqualTo: logedinUser!.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
}

  static Future<List<Collaboratormodal>> getAllProjectsCollaboratorsAsList(
    String projectID,
  ) async {
    final query = FirebaseFirestore.instance
        .collection(Colaboratorservice.kCollaboratorsCollections)
        .where(Colaboratorservice.kProjectID, isEqualTo: projectID);
    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Collaboratormodal.fromJson(doc.data()))
        .toList();
  }
}
