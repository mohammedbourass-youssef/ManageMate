import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Pages/ProjectCollaboratorsPage.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/models/ProjectModal.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:teamtasks/Pages/TasksPage.dart';

class Projectinfo extends StatelessWidget {
  const Projectinfo({super.key, required this.project});
  final Projectmodal project;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color(kSecondaryColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.folder_open, color: Colors.white, size: 23),
              ),
              Text(
                project.projectName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Helperfunctions.getColor(project.status),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Helperfunctions.getText(project.status)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person_2_outlined),
              SizedBox(width: 30),
              Text(
                project.adminName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border(
                top: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
                left: BorderSide(color: Colors.white),
                right: BorderSide(color: Colors.white),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Iconify(Mdi.github, color: Colors.deepPurple, size: 30),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    project.githubLink,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Iconify(Mdi.clock, color: Colors.white),
              SizedBox(width: 30),
              Text(
                Helperfunctions.getFormatTime(project.createdDatefeild),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kSecondaryColor),
                ),

                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Projectcollaboratorspage.id,
                    arguments: project,
                  );
                },

                child: Text(
                  'View Collaborators',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Taskspage.id,
                    arguments: project,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kSecondaryColor),
                ),
                child: Text('View Taks', style: TextStyle(color: Colors.white)),
              ),
              (project.status != EnProjectStatus.comlited.index)
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.cancel_sharp,
                        color: Colors.red,
                        size: 33,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
