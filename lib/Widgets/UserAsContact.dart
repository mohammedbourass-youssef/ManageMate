import 'package:flutter/material.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';

class Userascontact extends StatelessWidget {
  const Userascontact({
    super.key,
    required this.color,
    required this.name,
    required this.role,
  });
  final Color color;
  final String role;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      margin: EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: color.withValues(alpha: 1.0)),
            ),
            child: Text(
              Helperfunctions.getInitials(name),
              style: TextStyle(
                color: color.withValues(alpha: 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role, style: TextStyle(color: Colors.grey)),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
