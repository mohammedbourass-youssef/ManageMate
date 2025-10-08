import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Pages/AddNewProjects.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Widgets/Dashboard.dart';
import 'package:teamtasks/Widgets/MyTasks.dart';
import 'package:teamtasks/Widgets/Notifications.dart';
import 'package:teamtasks/Widgets/Projects.dart';
import 'package:teamtasks/Widgets/MyCollaborations.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const id = 'HomePage';
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedindex = 0;

  void _changeToSelectedIndex(index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List<Widget> _homeites = [
    Dashboard(),
    Projects(),
    Mytasks(),
    Mycollaborations(),
    Notifications(),
  ];
  void _addNew() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(kSecondaryColor),
        titlePadding: EdgeInsets.only(bottom: 20, left: 20, right: 0, top: 5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Projects ', style: TextStyle(color: Colors.white)),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel, size: 30),
            ),
          ],
        ),
        contentPadding: EdgeInsets.all(0),
        content: Addnewprojects(context: context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Notificationservice.countTotalUnseenNotifications(),
      builder: (context, counter) {
        return Scaffold(
          floatingActionButton: (_selectedindex == 1)
              ? FloatingActionButton(
                  onPressed: _addNew,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.add, size: 30, color: Colors.white),
                )
              : SizedBox(),
          backgroundColor: Color(kPimaryColor),
          body: _homeites[_selectedindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _changeToSelectedIndex,
            currentIndex: _selectedindex,
            backgroundColor: Color(kPimaryColor), // Primary background color
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple, // Color for the selected item
            unselectedItemColor:
                Colors.white70, // Slightly faded color for unselected items
            showUnselectedLabels: true,

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'Projects',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'My Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections_sharp),
                label: 'collaborations',
              ),
              BottomNavigationBarItem(
                icon: counter.hasData && counter.data != 0
                    ? Badge(
                        label: Text('${counter.data}'),
                        child: Icon(Icons.notifications),
                      )
                    : Icon(Icons.notifications),
                label: 'Notifications',
              ),
            ],
          ),
        );
      },
    );
  }
}
