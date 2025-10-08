import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';

class Collaboratormodal {
  String iD;
  String projectID;
  String projectName;
  String collaborator;
  String collaboratorName;
  String projectgithub;
  DateTime createdDate;
  int statisticsNumberOfTasks;
  bool isAdmin;
  Collaboratormodal({
    required this.iD,
    required this.projectID,
    required this.collaborator,
    required this.collaboratorName,
    required this.createdDate,
    required this.statisticsNumberOfTasks,
    required this.isAdmin,
    required this.projectName,
    required this.projectgithub,
  });

  factory Collaboratormodal.fromJson(data) {
    Timestamp ts = data[Colaboratorservice.kCreatedDate];
    return Collaboratormodal(
      iD: data[Colaboratorservice.kID],
      projectID: data[Colaboratorservice.kProjectID],
      collaborator: data[Colaboratorservice.kCollaborator],
      collaboratorName: data[Colaboratorservice.kCollaboratorNAme],
      createdDate: ts.toDate(),
      statisticsNumberOfTasks:
          data[Colaboratorservice.kStatisticsNumberOfTasks],
      isAdmin: data[Colaboratorservice.kIsAdmin],
      projectName: data[Colaboratorservice.kprojectName],
      projectgithub: data[Colaboratorservice.kprojectGithub],
    );
  }
}
