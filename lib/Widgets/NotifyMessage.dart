import 'package:flutter/material.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';
import 'package:teamtasks/models/NotficationModal.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Notifymessage extends StatefulWidget {
  const Notifymessage({super.key, required this.notify});
  final Notficationmodal notify;

  @override
  State<Notifymessage> createState() => _NotifymessageState();
}

class _NotifymessageState extends State<Notifymessage> {
  void _turnToSeen() {
    widget.notify.seen = true;
    Notificationservice.markAsSeen(widget.notify.iD);
    setState(() {});
  }

  void _acceptTheProjectRequest() async {
    try {
      await Colaboratorservice.addProjectCollaborator(
        Collaboratormodal(
          iD: 'nn',
          projectID: widget.notify.projectID,
          collaborator: widget.notify.receiverID,
          collaboratorName: widget.notify.recievrname,
          createdDate: DateTime.now(),
          statisticsNumberOfTasks: 0,
          isAdmin: false,
          projectName: widget.notify.projectName,
          projectgithub: widget.notify.projectGithub,
        ),
      );
      await Projectsservice.changeProjectStatus(
        widget.notify.projectID,
        EnProjectStatus.inprogress.index,
      );
      Helperfunctions.showSnackBar(
        context,
        'Congratulations, you are now a memeber of project ${widget.notify.projectName}',
        Colors.green,
      );
      Notificationservice.sendNotifications(
        Notficationmodal(
          iD: 'moo',
          type: EnNotifyType.information.index,
          projectID: widget.notify.projectID,
          receiverID: widget.notify.senderID,
          seen: false,
          senderID: logedinUser!.id,
          createdAt: DateTime.now(),
          recievrname: widget.notify.senderName,
          projectName: widget.notify.projectName,
          senderName: '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
          message: messages[1],
          projectGithub: 'nogithubneeded',
        ),
      );
      _turnToSeen();
    } catch (e) {
      Helperfunctions.showSnackBar(context, 'Error : $e', Colors.red);
    }
  }

  void _acceptTheTaskRequest() async {
    try {
      await Taskservices.addTask(
        Taskmodal(
          id: 'gbwiuhsdaiu',
          status: EnTaskSatate.inprocessus.index,
          projectId: widget.notify.projectID,
          projectName: widget.notify.projectName,
          projectGithub: widget.notify.projectGithub,
          adminName: widget.notify.senderName,
          collaboratorId: widget.notify.receiverID,
          collaboratorName: widget.notify.recievrname,
          adminID: widget.notify.senderID,
          createdAt: DateTime.now(),
          lastDate: DateTime.now(),
        ),
      );
      await Notificationservice.sendNotifications(
        Notficationmodal(
          iD: 'hj',
          type: EnNotifyType.information.index,
          projectID: widget.notify.projectID,
          receiverID: widget.notify.senderID,
          seen: false,
          senderID: logedinUser!.id,
          createdAt: DateTime.now(),
          recievrname: widget.notify.senderName,
          projectName: widget.notify.projectName,
          senderName: '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
          message: messages[4],
          projectGithub: widget.notify.projectGithub,
        ),
      );
      Helperfunctions.showSnackBar(
        context,
        'Congratulations , you have new task',
        Colors.green,
      );
      _turnToSeen();
    } catch (e) {
      Helperfunctions.showSnackBar(context, 'Error : $e', Colors.red);
    }
  }

  void _acceptedTheRequest() async {
    if (widget.notify.type == EnNotifyType.sendinvitation.index) {
      _acceptTheProjectRequest();
    } else {
      _acceptTheTaskRequest();
    }
  }

  //decline

  void _declineinvitation() {
    try {
      Notificationservice.sendNotifications(
        Notficationmodal(
          iD: 'moo',
          type: EnNotifyType.information.index,
          projectID: widget.notify.projectID,
          receiverID: widget.notify.senderID,
          seen: false,
          senderID: logedinUser!.id,
          createdAt: DateTime.now(),
          recievrname: widget.notify.senderName,
          projectName: widget.notify.projectName,
          senderName: '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
          message: messages[2],
          projectGithub: 'nogithubacces',
        ),
      );
      _turnToSeen();
    } catch (e) {
      Helperfunctions.showSnackBar(context, 'Error : $e', Colors.red);
    }
  }

  void _declineTheTask() {}
  void _declinedTheRequest() {
    if (widget.notify.type == EnNotifyType.sendinvitation.index) {
      _declineinvitation();
    } else {
      _declineTheTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.notify.seen &&
            widget.notify.type == EnNotifyType.information.index) {
          _turnToSeen();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (widget.notify.seen)
              ? Color(kSecondaryColor)
              : Color(kThirdColor),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (widget.notify.seen) ? Colors.white : Colors.deepPurple,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon avatar
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (widget.notify.seen) ? Colors.white : Colors.deepPurple,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.notifications_active_outlined,
                color: (widget.notify.seen)
                    ? Color(kSecondaryColor)
                    : Colors.purpleAccent,
              ),
            ),

            // Expanded Column so layout works inside Row
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Top row with type + time
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          Helperfunctions.notificationMessage(
                            widget.notify.type,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        Icons.access_time_outlined,
                        color: Colors.blueGrey,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        Helperfunctions.timeAgo(widget.notify.createdAt),
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // Sender row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.notify.senderName,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        widget.notify.message,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),

                  // Project row
                  Row(
                    children: [
                      const Icon(
                        Icons.folder_open_outlined,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.notify.projectName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // Buttons row
                  (widget.notify.seen ||
                          widget.notify.type == EnNotifyType.information.index)
                      ? SizedBox()
                      : Row(
                          children: [
                            GestureDetector(
                              onTap: _acceptedTheRequest,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.check, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      "Accept",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: _declinedTheRequest,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.close_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Decline",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
