import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teamtasks/Pages/CollaboratorTasks.dart';
import 'package:teamtasks/Pages/EnterPage.dart';
import 'package:teamtasks/Pages/HomePage.dart';
import 'package:teamtasks/Pages/LoginPage.dart';
import 'package:teamtasks/Pages/ProjectCollaboratorsPage.dart';
import 'package:teamtasks/Pages/RegisterPage.dart';
import 'package:teamtasks/firebase_options.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';
import 'package:teamtasks/models/ProjectModal.dart';
import 'package:teamtasks/Pages/TasksPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Homepage.id: (context) => Homepage(),
        Enterpage.id: (context) => Enterpage(),
        Loginpage.id: (context) => Loginpage(),
        Registerpage.id: (context) => Registerpage(),
        Projectcollaboratorspage.id: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Projectmodal;
          return Projectcollaboratorspage(project: args);
        },
        Taskspage.id: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Projectmodal;
          return Taskspage(project: args);
        },
        Collaboratortasks.id: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Collaboratormodal;
          return Collaboratortasks(project: args);
        },
      },
      debugShowCheckedModeBanner: false, // hide debug banner
      title: 'Task manager',
      theme: ThemeData(
        primarySwatch: Colors.blue, // set your theme color
      ),
      initialRoute: Enterpage.id, // first screen of your app
    );
  }
}
