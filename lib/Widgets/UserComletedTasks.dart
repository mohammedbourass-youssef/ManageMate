import 'package:flutter/material.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/Widgets/statisticsWidgets.dart';

class Usercomletedtasks extends StatefulWidget {
  const Usercomletedtasks({super.key});

  @override
  State<Usercomletedtasks> createState() => _UsercomletedtasksState();
}

class _UsercomletedtasksState extends State<Usercomletedtasks> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Taskservices.userComleteTasksCountStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: const Text('No data'));
        }
        return Statisticswidgets(
          icon: Icon(Icons.check_box_outlined, size: 50, color: Colors.white),
          name: 'Tasks Completed',
          statistics: snapshot.data!,
        );
      },
    );
  }
}
