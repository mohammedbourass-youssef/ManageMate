import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Pages/CollaboratorTasks.dart';
import 'package:teamtasks/models/CollaboratorModal.dart';

class Mycollaborationinproject extends StatelessWidget {
  const Mycollaborationinproject({super.key, required this.coll});
  final Collaboratormodal coll;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 10, left: 10, top: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(kThirdColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${coll.collaboratorName}/${coll.projectName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              (coll.isAdmin)
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple,
                      ),
                      child: Text(
                        'Admin',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Project ID : ',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(width: 10),
              Text(
                coll.projectID,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          //the Created date
          Container(
            width: double.infinity,
            height: 65,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(kfouthColor),
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Iconify(Mdi.clock, color: Colors.purple),
                SizedBox(width: 10),
                Column(
                  children: [
                    Align(
                      child: Text(
                        'Created ',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    Text(
                      Helperfunctions.getFormatTime(coll.createdDate),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(kfouthColor),
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Iconify(Mdi.clock, color: Colors.purple),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    coll.projectgithub,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          (coll.isAdmin)
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Collaboratortasks.id,
                      arguments: coll,
                    );
                  },

                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task),
                        SizedBox(width: 10),
                        Text(
                          'View my Tasks',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
