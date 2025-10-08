import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.text,
    required this.onClick,
    this.padding,
  });
  final String text;
  final VoidCallback onClick;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: padding,
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Color(kPimaryColor),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
