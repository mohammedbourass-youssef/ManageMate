import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamtasks/Services/UsersServices.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/Widgets/USerSimpleInfo.dart';
import 'package:teamtasks/models/ProjectModal.dart';
import 'package:teamtasks/models/UserModal.dart';

class Searchusers extends StatefulWidget {
  const Searchusers({super.key, required this.context ,required this.project});
  final BuildContext context;
  final Projectmodal project;
  @override
  State<Searchusers> createState() => _SearchusersState();
}

class _SearchusersState extends State<Searchusers> {
  String _fullname = '';
  void _filter(data) {
    _fullname = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Usersservices.getUsersFilter(_fullname),
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          height: 900,
          child: Column(
            children: [
              Customtext(
                onChanged: _filter,
                hinttext: 'Search Using Full Name',
                icon: Icon(Icons.search),
              ),
              SizedBox(height: 20),
              Expanded(
                child: snapshot.data == null
                    ? Center(
                        child: Text(
                          'Sorry , error Ocupped try again !!',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      )
                    : (snapshot.data!.docs.isEmpty)
                    ? Center(
                        child: Text(
                          'No users !!',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Usersimpleinfo(
                            project: widget.project,
                            user: Usermodal.getFromJson(
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
