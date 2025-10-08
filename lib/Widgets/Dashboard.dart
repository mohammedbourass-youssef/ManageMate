import 'package:flutter/material.dart';
import 'package:teamtasks/Widgets/CurrentUserInfo.dart';
import 'package:teamtasks/Widgets/PlatformUserTotal.dart';
import 'package:teamtasks/Widgets/UserComletedTasks.dart';
import 'package:teamtasks/Widgets/UserTotalCollaborationWidget.dart';
import 'package:teamtasks/Widgets/UserTotalProjectsWidget.dart';
import 'package:teamtasks/Widgets/totalPrjectsCount.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Currentuserinfo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your Activity',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          Usertotalprojectswidget(),
          Usertotalcollaborationwidget(),
          Usercomletedtasks(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Platform Overview',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          Totalprjectscount(),
          Platformusertotal(),
        ],
      ),
    );
  }
}
