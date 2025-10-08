import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Services/TaskServices.dart';

class Taskmodal {
  final String id;
  int status;
  final String projectId;
  final String projectName;
  final String projectGithub;
  final String adminName;
  final String collaboratorId;
  final String collaboratorName;
  final DateTime createdAt;
  final DateTime lastDate;
  final String adminID;
  Taskmodal({
    required this.id,
    required this.status,
    required this.projectId,
    required this.projectName,
    required this.projectGithub,
    required this.adminName,
    required this.collaboratorId,
    required this.collaboratorName,
    required this.createdAt,
    required this.lastDate,
    required this.adminID,
  });

  /// Create Task object from Firestore document
  factory Taskmodal.fromJson(json) {
    return Taskmodal(
      id: json[Taskservices.kTaskID] as String,
      status: json[Taskservices.kStutus] as int,
      projectId: json[Taskservices.kprojectID] as String,
      projectName: json[Taskservices.kprojectName] as String,
      projectGithub: json[Taskservices.kprojectGithub] as String,
      adminName: json[Taskservices.kAdmin] as String,
      collaboratorId: json[Taskservices.kCollaboratorID] as String,
      collaboratorName: json[Taskservices.kCollaboratorName] as String,
      createdAt: (json[Taskservices.kCreatedAt] as Timestamp).toDate(),
      lastDate: (json[Taskservices.kLastDate] as Timestamp).toDate(),
      adminID: json[Taskservices.kAdminID] as String,
    );
  }

  /// Convert Task object to JSON (for saving to Firestore)
  Map<String, dynamic> toJson() {
    return {
      Taskservices.kTaskID: id,
      Taskservices.kStutus: status,
      Taskservices.kprojectID: projectId,
      Taskservices.kprojectName: projectName,
      Taskservices.kprojectGithub: projectGithub,
      Taskservices.kAdmin: adminName,
      Taskservices.kCollaboratorID: collaboratorId,
      Taskservices.kCollaboratorName: collaboratorName,
      Taskservices.kCreatedAt: createdAt,
      Taskservices.kLastDate: lastDate,
      Taskservices.kAdminID: adminID,
    };
  }
}
