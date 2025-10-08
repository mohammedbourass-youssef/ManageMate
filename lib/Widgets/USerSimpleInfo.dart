import 'package:flutter/material.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/models/NotficationModal.dart';
import 'package:teamtasks/models/ProjectModal.dart';
import 'package:teamtasks/models/UserModal.dart';

class Usersimpleinfo extends StatefulWidget {
  const Usersimpleinfo({super.key, required this.user, required this.project});
  final Usermodal user;
  final Projectmodal project;
  @override
  State<Usersimpleinfo> createState() => _UsersimpleinfoState();
}

class _UsersimpleinfoState extends State<Usersimpleinfo> {
  void _addUserToProjects() async {
    try {
      bool isExist = await Colaboratorservice.isAlreadyAnCollaborator(
        widget.user.id,
        widget.project.iD,
      );
      if (isExist) {
        _isExistAlready = true;
        Helperfunctions.showSnackBar(
          context,
          'An Error , this user already collaborator',
          Colors.orange,
        );
      } else {
        _isInvited = true;
        await Notificationservice.sendNotifications(
          Notficationmodal(iD: 'jaiuhnd',
          type: EnNotifyType.sendinvitation.index,
          projectID: widget.project.iD,
          receiverID: widget.user.id,
          seen: false,
          senderID: logedinUser!.id,
          createdAt: DateTime.now(),
          recievrname: '${widget.user.firstName} ${widget.user.lastNameName}',
          projectName: widget.project.projectName,
          senderName: '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
          message: messages[0],
          projectGithub: widget.project.githubLink
         )
        );
      }
    } catch (e) {
      Helperfunctions.showSnackBar(
        context,
        'An Error Try Again $e',
        Colors.red,
      );
      _isInvited = false;
      _isExistAlready = false;
    }
    setState(() {});
  }

  bool _isInvited = false;
  bool _isExistAlready = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,

      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),

        color: Color(kSecondaryColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Helperfunctions.getRandomColor(),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  Helperfunctions.getInitials(
                    '${widget.user.firstName} ${widget.user.lastNameName}',
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 7),
              Column(
                children: [
                  Text(
                    '${widget.user.firstName} ${widget.user.lastNameName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.email_outlined, color: Colors.white, size: 20),
                      SizedBox(width: 3),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.user.email,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.punch_clock_sharp,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 3),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        Helperfunctions.getFormatTime(widget.user.createdDate),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Icon(Icons.ssid_chart_sharp, color: Colors.white),
                    Text(
                      '  (${widget.user.statistics}) Projects',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (!_isExistAlready && !_isInvited)
                    ? _addUserToProjects
                    : null, // same as onPressed
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: _isInvited
                        ? Colors.green
                        : (_isExistAlready
                              ? Color(kPimaryColor)
                              : Colors.purpleAccent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _isInvited
                        ? 'Invited Succefully'
                        : _isExistAlready
                        ? 'Already collaborator'
                        : 'Invite to Project',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
