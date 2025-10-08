import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/Widgets/TaskStatus.dart';
import 'package:teamtasks/models/NotficationModal.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Mytasksitem extends StatefulWidget {
  const Mytasksitem({super.key, required this.task});
  final Taskmodal task;

  @override
  State<Mytasksitem> createState() => _MytasksitemState();
}

class _MytasksitemState extends State<Mytasksitem> {
  void _settaskComplited() async {
    widget.task.status = EnTaskSatate.complited.index;
    await Taskservices.changeTaskStatus(widget.task.id, widget.task.status);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(kTaskColor),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple),
      ),
      child: Column(
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

          //title
          Row(
            children: [
              Flexible(
                child: Text(
                  'project ID : ${widget.task.projectId}',
                  style: TextStyle(color: Colors.purple, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10),
              Text(
                Helperfunctions.formatCreatedDate(widget.task.createdAt),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          Divider(color: Colors.purple.shade900),
          (widget.task.status == EnTaskSatate.inprocessus.index)
              ? GestureDetector(
                  onTap: _complitethisTask,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    width: 170,
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
                        Iconify(Mdi.check_circle_outline, color: Colors.white),
                        Text(
                          'Complete Task',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  void _complitethisTask() {
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
          height: 320,
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
                'Confirmation Required',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please make sure you have completed all the requirements requested by the Admin before submitting, as they will verify them.',
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
                        receiverID: widget.task.adminID,
                        seen: false,
                        senderID: logedinUser!.id,
                        createdAt: DateTime.now(),
                        recievrname: widget.task.adminName,
                        projectName: widget.task.projectName,
                        senderName:
                            '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
                        message: messages[5],
                        projectGithub: widget.task.projectGithub,
                      ),
                    );
                    Helperfunctions.showSnackBar(
                      context,
                      'notification send succefully',
                      Colors.green,
                    );

                    Navigator.pop(context);
                  } catch ( e) {
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
