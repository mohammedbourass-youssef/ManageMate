import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  const Customtext({
    super.key,
    required this.hinttext,
    required this.icon,
    this.validator,
    this.onChanged,
  });
  final String hinttext;
  final Icon icon;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          hintText: hinttext,
        ),
      ),
    );
  }
}
