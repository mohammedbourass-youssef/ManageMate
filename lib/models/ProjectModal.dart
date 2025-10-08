import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Services/ProjectsService.dart';

class Projectmodal {
  String iD;
  String projectName;
  String githubLink;
  String adminID;
  String adminName;
  DateTime createdDatefeild;
  int status;
  int runingTasks;
  Projectmodal({
    required this.adminID,
    required this.createdDatefeild,
    required this.githubLink,
    required this.iD,
    required this.projectName,
    required this.status,
    required this.adminName,
    required this.runingTasks
  });

  factory Projectmodal.fromJson(data) {
    Timestamp ts = data[Projectsservice.kCreatedDatefeild];
    return Projectmodal(
      adminID: data[Projectsservice.kAdmin],
      createdDatefeild: ts.toDate(),
      githubLink: data[Projectsservice.kGithubLink],
      iD: data[Projectsservice.kID],
      projectName: data[Projectsservice.kProjectName],
      status: data[Projectsservice.kStatus],
      adminName: data[Projectsservice.kAdminName] as String,
      runingTasks : data[Projectsservice.kRunningTasks] as int
    );
  }
}
