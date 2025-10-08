import 'package:flutter/material.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';
import 'package:teamtasks/models/NotficationModal.dart';
import 'package:teamtasks/models/ProjectModal.dart';

class Collaboratoritem extends StatelessWidget {
  const Collaboratoritem({
    super.key,
    required this.collaborator,
    required this.project,
  });
  final Collaboratormodal collaborator;
  final Projectmodal project;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(kSecondaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Helperfunctions.getRandomColor(),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      Helperfunctions.getInitials(
                        collaborator.collaboratorName,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    collaborator.collaboratorName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              (collaborator.isAdmin)
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple,
                      ),
                      child: Text(
                        'Admin',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Row(
                children: [
                  Icon(Icons.person_2_outlined),
                  Column(
                    children: [
                      Text(
                        'Tasks',
                        style: TextStyle(color: Color(kPimaryColor)),
                      ),
                      Text(
                        collaborator.statisticsNumberOfTasks.toString(),
                        style: TextStyle(color: Color(kPimaryColor)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 70),
              Row(
                children: [
                  Icon(Icons.date_range_outlined),
                  Column(
                    children: [
                      Text(
                        'Joined',
                        style: TextStyle(color: Color(kPimaryColor)),
                      ),
                      Text(
                        Helperfunctions.getFormatTime(collaborator.createdDate),
                        style: TextStyle(color: Color(kPimaryColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          (project.status != EnProjectStatus.comlited.index)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _setCollaboratorAsAdmin,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.purple,
                          style: BorderStyle.solid,
                        ),
                        backgroundColor: Color(kSecondaryColor),
                        shadowColor: Colors.purple,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.security_sharp, color: Colors.purple),
                          SizedBox(width: 7),
                          Text(
                            'Make Admin',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                    (logedinUser!.id != project.adminID || collaborator.isAdmin)
                        ? SizedBox()
                        : ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Color(kSecondaryColor),
                                  titlePadding: EdgeInsets.only(
                                    bottom: 20,
                                    left: 20,
                                    right: 0,
                                    top: 5,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Add Task ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel, size: 30),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  content: Container(
                                    height: 320,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade200,
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.info_outline,
                                            color: Colors.red.shade900,
                                            size: 60,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Confirm Task Assignment',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Are you sure you want to assign a new task to this person? They have the option to accept or decline it. It’s recommended to reach out to them before proceeding.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                        SizedBox(height: 30),
                                        GestureDetector(
                                          onTap: () {
                                            try {
                                              Notificationservice.sendNotifications(
                                                Notficationmodal(
                                                  iD: 'bjnk',
                                                  type: EnNotifyType
                                                      .newtask
                                                      .index,
                                                  projectID: project.iD,
                                                  receiverID:
                                                      collaborator.collaborator,
                                                  seen: false,
                                                  senderID: logedinUser!.id,
                                                  createdAt: DateTime.now(),
                                                  recievrname: collaborator
                                                      .collaboratorName,
                                                  projectName:
                                                      project.projectName,
                                                  senderName:
                                                      '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
                                                  message: messages[3],
                                                  projectGithub:
                                                      project.githubLink,
                                                ),
                                              );
                                              Helperfunctions.showSnackBar(
                                                context,
                                                'notification send succefully',
                                                Colors.green,
                                              );
                                              Navigator.pop(context);
                                            } catch (e) {
                                              Helperfunctions.showSnackBar(
                                                context,
                                                'Error : $e',
                                                Colors.red,
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 70,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                              'Asign Task',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.orange,
                                style: BorderStyle.solid,
                              ),
                              backgroundColor: Color(kSecondaryColor),
                              shadowColor: Colors.orange,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.task, color: Colors.orange),
                              ],
                            ),
                          ),
                    (logedinUser!.id != project.adminID)
                        ? SizedBox()
                        : ElevatedButton(
                            onPressed: _deletecollaboration,
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.red,
                                style: BorderStyle.solid,
                              ),
                              backgroundColor: Color(kSecondaryColor),
                              shadowColor: Colors.red,
                            ),
                            child: Row(
                              children: [Icon(Icons.delete, color: Colors.red)],
                            ),
                          ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  void _setCollaboratorAsAdmin() {}

  void _deletecollaboration() {}
}
