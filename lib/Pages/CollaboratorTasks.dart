import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/Widgets/MyTasksItem.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Collaboratortasks extends StatefulWidget {
  const Collaboratortasks({super.key, required this.project});
  static const id = 'CollaboratortasksID';
  final Collaboratormodal project;
  @override
  State<Collaboratortasks> createState() => _MytasksState();
}

class _MytasksState extends State<Collaboratortasks> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Taskservices.getProjectsAllTasksForThisUSer(
        widget.project.projectID,
      ),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        }

        if (asyncSnapshot.hasError) {
          // Display error message
          return Center(
            child: Text('An error occurred: ${asyncSnapshot.error}'),
          );
        }
        final data = asyncSnapshot.data;

        // Check if data is null or empty
        if (data == null || data.docs.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return Scaffold(
          backgroundColor: Color(kPimaryColor),
          appBar: AppBar(
            backgroundColor: Color(kPimaryColor),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back ,color: Colors.white,),
            ),
            title: Row(
              children: [
                //header
                SizedBox(width: 30),
                Icon(Icons.task, color: Colors.deepPurple, size: 30),
                SizedBox(width: 10),
                Text(
                  'My Tasks',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: asyncSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Mytasksitem(
                      task: Taskmodal.fromJson(asyncSnapshot.data!.docs[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
