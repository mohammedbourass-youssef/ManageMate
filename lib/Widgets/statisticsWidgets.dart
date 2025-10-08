import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';

class Statisticswidgets extends StatelessWidget {
  const Statisticswidgets({
    super.key,
    required this.icon,
    required this.name,
    required this.statistics,
  });
  final Icon icon;
  final String name;
  final int statistics;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(kThirdColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(kSecondaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: icon,
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.grey, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                statistics.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
