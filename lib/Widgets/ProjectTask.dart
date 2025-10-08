import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/Widgets/TaskStatus.dart';
import 'package:teamtasks/Widgets/UserAsContact.dart';
import 'package:teamtasks/models/NotficationModal.dart';
import 'package:teamtasks/models/ProjectModal.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Projecttask extends StatefulWidget {
  const Projecttask({super.key, required this.task, required this.project});
  final Taskmodal task;
  final Projectmodal project;

  @override
  State<Projecttask> createState() => _ProjecttaskState();
}

class _ProjecttaskState extends State<Projecttask> {
  void _settaskComplited() async {
    widget.task.status = EnTaskSatate.verified.index;
    setState(() {});
    await Taskservices.changeTaskStatus(widget.task.id, widget.task.status);
    await Projectsservice.changeprojectRuningTaks(widget.task.projectId, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      decoration: BoxDecoration(
        color: Color(kTaskColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${widget.task.adminName}/ ${widget.task.projectName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Taskstatus(status: widget.task.status),
            ],
          ),
          Text(
            'ID : ${widget.task.id}',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Row(
            children: [
              Iconify(Mdi.github, color: Colors.purple),
              Flexible(
                child: Text(
                  widget.task.projectGithub,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
          Userascontact(
            color: Colors.purple,
            name: widget.task.adminName,
            role: 'Admin',
          ),
          Userascontact(
            color: Colors.blueAccent,
            name: widget.task.collaboratorName,
            role: 'Collaborator',
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey.shade800),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helperfunctions.formatCreatedDate(widget.task.createdAt),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              (logedinUser!.id == widget.project.adminID &&
                      widget.task.status == EnTaskSatate.complited.index)
                  ? GestureDetector(
                      onTap: _verifiedthisTask,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade500,
                          border: Border.all(
                            color: Color(kPimaryColor),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Iconify(
                              Mdi.check_circle_outline,
                              color: Colors.white,
                            ),
                            Text(
                              'Mark as verified',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  void _verifiedthisTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(kSecondaryColor),
        titlePadding: EdgeInsets.only(bottom: 20, left: 20, right: 0, top: 5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Task ', style: TextStyle(color: Colors.white)),
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
          height: 400,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.red.shade900,
                  size: 60,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please Verify the Code on GitHub',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Before continuing, make sure you’ve reviewed and verified the latest code changes on GitHub. Are you sure you want to proceed?',
                style: TextStyle(color: Colors.white, fontSize: 14),
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  try {
                    _settaskComplited();
                    Notificationservice.sendNotifications(
                      Notficationmodal(
                        iD: 'bjnk',
                        type: EnNotifyType.information.index,
                        projectID: widget.task.projectId,
                        receiverID: widget.task.collaboratorId,
                        seen: false,
                        senderID: logedinUser!.id,
                        createdAt: DateTime.now(),
                        recievrname: widget.task.collaboratorName,
                        projectName: widget.task.projectName,
                        senderName:
                            '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
                        message: messages[6],
                        projectGithub: widget.task.projectGithub,
                      ),
                    );
                    Helperfunctions.showSnackBar(
                      context,
                      'notification send succefully',
                      Colors.green,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    print(' this is  : $e');
                    Helperfunctions.showSnackBar(
                      context,
                      'Error : $e',
                      Colors.red,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
