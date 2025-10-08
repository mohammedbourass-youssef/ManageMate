import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamtasks/Services/ColaboratorService.dart';
import 'package:teamtasks/Widgets/CollaboratorItem.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';
import 'package:teamtasks/models/ProjectModal.dart';

class Projectcollaboratorsworking extends StatefulWidget {
  const Projectcollaboratorsworking({super.key, required this.project});
  final Projectmodal project;
  @override
  State<Projectcollaboratorsworking> createState() =>
      _ProjectcollaboratorsworkingState();
}

class _ProjectcollaboratorsworkingState
    extends State<Projectcollaboratorsworking> {
  String _filteritem = '';

  void _filter(data) {
    _filteritem = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Colaboratorservice.getAllProjectsCollaborators(
        widget.project.iD,
        _filteritem,
      ),
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Customtext(
                onChanged: _filter,
                hinttext: 'Search collaborators',
                icon: Icon(Icons.search),
              ),
              SizedBox(height: 10),
              (snapshot.data == null)
                  ? Center(
                      child: Text(
                        'Net Error , try Again later',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  : (snapshot.data!.docs.isEmpty)
                  ? Center(
                      child: Text(
                        'There is not collaboration , in this project sorry !!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Collaboratoritem(
                            project:widget.project,
                            collaborator: Collaboratormodal.fromJson(
                              snapshot.data!.docs[index],
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
}
