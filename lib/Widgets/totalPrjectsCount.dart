import 'package:flutter/material.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Widgets/statisticsWidgets.dart';

class Totalprjectscount extends StatefulWidget {
  const Totalprjectscount({super.key});

  @override
  State<Totalprjectscount> createState() => _TotalprjectscountState();
}

class _TotalprjectscountState extends State<Totalprjectscount> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Projectsservice.platformPojectsCountStream(),
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
          icon: Icon(Icons.folder_open_outlined, size: 50, color: Colors.white),
          name: 'projects',
          statistics: snapshot.data!,
        );
      },
    );
  }
}
