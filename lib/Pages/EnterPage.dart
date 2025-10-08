import 'package:flutter/material.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Pages/LoginPage.dart';
import 'package:teamtasks/Pages/RegisterPage.dart';
import 'package:teamtasks/Widgets/CustomButton.dart';

class Enterpage extends StatelessWidget {
  const Enterpage({super.key});
  static const id = 'Enterpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPimaryColor),
      body: Column(
        children: [
          Spacer(flex: 1),
          Image.asset('lib/assets/images/Logo.png', height: 400),
          Spacer(flex: 1),
          SizedBox(height: 50),
          Custombutton(
            text: 'Sign In',
            onClick: () {
              Navigator.pushNamed(context, Loginpage.id);
            },
            padding: EdgeInsets.symmetric(horizontal: 30),
          ),
          SizedBox(height: 20),
          Custombutton(
            text: 'Register',
            onClick: () {
              Navigator.pushNamed(context, Registerpage.id);
            },
            padding: EdgeInsets.symmetric(horizontal: 30),
          ),
          Spacer(flex: 4),
        ],
      ),
    );
  }
}
