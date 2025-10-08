import 'package:flutter/material.dart';
import 'package:teamtasks/Services/TaskServices.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/Widgets/MyTasksItem.dart';
import 'package:teamtasks/models/TaskModal.dart';

class Mytasks extends StatefulWidget {
  const Mytasks({super.key});

  @override
  State<Mytasks> createState() => _MytasksState();
}

class _MytasksState extends State<Mytasks> {
  String _filterItem = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Taskservices.getCurrentUSerTasks(_filterItem),
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

        return Column(
          children: [
            SizedBox(height: 30),
            Row(
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
            SizedBox(height: 30),
            //searchbox
            Customtext(
              hinttext: 'Search Using project name',
              icon: Icon(Icons.search),
              onChanged: _filter,
            ),
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
        );
      },
    );
  }

  _filter(String? p1) {
    _filterItem = p1!;
    setState(() {});
  }
}
