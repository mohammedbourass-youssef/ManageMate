import 'package:flutter/material.dart';
import 'package:teamtasks/Services/UsersServices.dart';
import 'package:teamtasks/Widgets/statisticsWidgets.dart';

class Platformusertotal extends StatefulWidget {
  const Platformusertotal({super.key});

  @override
  State<Platformusertotal> createState() => _PlatformusertotalState();
}

class _PlatformusertotalState extends State<Platformusertotal> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Usersservices.platformUsersCountStream(),
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
          icon: Icon(Icons.person, size: 50, color: Colors.white),
          name: 'Active Users',
          statistics: snapshot.data!,
        );
      },
    );
  }
}
