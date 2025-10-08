import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/Widgets/ProjectTask.dart';
import 'package:teamtasks/models/ProjectModal.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Taskspage extends StatefulWidget {
  const Taskspage({super.key, required this.project});
  final Projectmodal project;
  static const id = 'TasksPage';
  @override
  State<Taskspage> createState() => _TaskspageState();
}

class _TaskspageState extends State<Taskspage> {
  bool _loading = false;
  void _setLoading(bool value) {
    _loading = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Taskservices.getProjectsAllTasks(widget.project.iD),
      builder: (context, asyncSnapshot) {
        return Scaffold(
          floatingActionButton:
              (widget.project.runingTasks == 0 &&
                  widget.project.status == EnProjectStatus.inprogress.index)
              ? FloatingActionButton(
                  onPressed: _endTheTask,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, size: 45, color: Colors.white),
                )
              : null,
          backgroundColor: Color(kPimaryColor),

          appBar: AppBar(
            backgroundColor: Color(kPimaryColor),
            title: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.task, color: Colors.white, size: 23),
                ),
                Expanded(
                  child: Text(
                    'Tasks',
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: (asyncSnapshot.data == null)
              ? Center(
                  child: Text(
                    'Sorry Try again',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : (asyncSnapshot.data!.docs.isEmpty)
              ? Center(
                  child: Text(
                    'No Task For this Project , try to add one',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Text(
                      'Track and manage your development projects',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: asyncSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Projecttask(
                            project: widget.project,
                            task: Taskmodal.fromJson(
                              asyncSnapshot.data!.docs[index],
                            ),
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

  void _endTheTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(kSecondaryColor),
        titlePadding: EdgeInsets.only(bottom: 20, left: 20, right: 0, top: 5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Message', style: TextStyle(color: Colors.white)),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel, size: 30),
            ),
          ],
        ),
        contentPadding: EdgeInsets.all(0),
        content: ModalProgressHUD(
          inAsyncCall: _loading,
          child: Container(
            height: 300,
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
                  'Project Completion Confirmation',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'All tasks have been verified.Please confirm that the project is finished.',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    try {
                      _setLoading(true);
                      await Projectsservice.endTheProject(widget.project);
                      _setLoading(false);
                      Helperfunctions.showSnackBar(
                        context,
                        'project End Succefully , try to start new project ',
                        Colors.green,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      _setLoading(true);
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
                      'finish',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
