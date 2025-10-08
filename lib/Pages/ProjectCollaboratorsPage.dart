import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Widgets/ProjectCollaboratorsWorking.dart';
import 'package:teamtasks/Widgets/SearchUsers.dart';
import 'package:teamtasks/models/ProjectModal.dart';

class Projectcollaboratorspage extends StatefulWidget {
  const Projectcollaboratorspage({super.key, required this.project});
  static const id = 'ProjectsCollaboratorsPage';
  final Projectmodal project;
  @override
  State<Projectcollaboratorspage> createState() =>
      _ProjectcollaboratorspageState();
}

class _ProjectcollaboratorspageState extends State<Projectcollaboratorspage> {
  void _addNew() {
    _isSearching = !_isSearching;
    setState(() {});
  }

  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kPimaryColor),
        actions: [
          (widget.project.status != EnProjectStatus.comlited.index)
              ? IconButton(
                  onPressed: _addNew,
                  icon: Icon(
                    (_isSearching) ? Icons.cancel : Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : SizedBox(),
        ],
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.folder_open, color: Colors.white, size: 23),
            ),
            Expanded(
              child: Text(
                'Memebers',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Color(kPimaryColor),
      body: (_isSearching)
          ? Searchusers(context: context, project: widget.project)
          : Projectcollaboratorsworking(project: widget.project),
    );
  }
}
