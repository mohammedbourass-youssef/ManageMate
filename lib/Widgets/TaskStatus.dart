import 'package:flutter/material.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';

class Taskstatus extends StatelessWidget {
  const Taskstatus({super.key, required this.status});
  final int status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Helperfunctions.getColorOfStatusTask(status).shade100,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Helperfunctions.getColorOfStatusTask(status).shade900,
          width: 2,
        ),
      ),
      child: Center(child: Helperfunctions.getTextForTask(status)),
    );
  }
}
