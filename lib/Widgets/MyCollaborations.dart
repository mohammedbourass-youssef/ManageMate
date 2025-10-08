import 'package:flutter/material.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/Widgets/MyCollaborationInProject.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';

class Mycollaborations extends StatefulWidget {
  const Mycollaborations({super.key});

  @override
  State<Mycollaborations> createState() => _MycollaborationsState();
}

class _MycollaborationsState extends State<Mycollaborations> {
  String _filterSTR = '';
  void _filter(value) {
    _filterSTR = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Colaboratorservice.getMyCollaboration(_filterSTR),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(),
          ); // loading state
        }

        if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }

        if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
          return Center(child: const Text('No data found')); // when no data
        }
        return Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                //header
                SizedBox(width: 30),
                Icon(
                  Icons.collections_sharp,
                  color: Colors.deepPurple,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'My Collaborations',
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
            Expanded(
              child: ListView.builder(
                itemCount: asyncSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Mycollaborationinproject(
                    coll: Collaboratormodal.fromJson(
                      asyncSnapshot.data!.docs[index],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
