import 'package:flutter/material.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Widgets/statisticsWidgets.dart';

class Usertotalcollaborationwidget extends StatefulWidget {
  const Usertotalcollaborationwidget({super.key});

  @override
  State<Usertotalcollaborationwidget> createState() =>
      _UsertotalcollaborationwidgetState();
}

class _UsertotalcollaborationwidgetState
    extends State<Usertotalcollaborationwidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Colaboratorservice.userCollaborationsCountStream(),
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
          icon: Icon(Icons.people_alt_outlined, size: 50, color: Colors.white),
          name: 'Collaborations',
          statistics: snapshot.data!,
        );
      },
    );
  }
}
