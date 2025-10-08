import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/Widgets/ProjectInfo.dart';
import 'package:teamtasks/models/ProjectModal.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  String x = '';
  void filter(value) {
    setState(() {
      x = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Projectsservice.getAllProjects(x),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No projects , Try create one',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          );
        }
        return Column(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.folder_open, color: Colors.white),
                ),
                Text(
                  'Projects',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Customtext(
                onChanged: filter,
                hinttext: 'Search by name',
                icon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Projectinfo(
                    project: Projectmodal.fromJson(snapshot.data!.docs[index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
