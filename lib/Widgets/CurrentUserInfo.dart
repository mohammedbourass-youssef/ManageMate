import 'package:flutter/material.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';

class Currentuserinfo extends StatelessWidget {
  const Currentuserinfo({super.key});
  final Color color = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 20),
      decoration: BoxDecoration(
        color: Color(kThirdColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: color.withValues(alpha: 1.0)),
                ),
                child: Text(
                  Helperfunctions.getInitials(
                    '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
                  ),
                  style: TextStyle(
                    color: color.withValues(alpha: 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 29,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    '${logedinUser!.firstName} ${logedinUser!.lastNameName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    logedinUser!.email,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          //the join date
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Color(kSecondaryColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back! 👋',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Helperfunctions.formatLoinedDate(logedinUser!.createdDate),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
