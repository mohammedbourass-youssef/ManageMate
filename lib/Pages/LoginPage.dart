import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Pages/HomePage.dart';
import 'package:teamtasks/Pages/RegisterPage.dart';
import 'package:teamtasks/Services/UsersServices.dart';
import 'package:teamtasks/Widgets/CustomButton.dart';
import 'package:teamtasks/Widgets/CustomText.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});
  static const id = 'LoginPage';

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String? _emailAddress;
  String? _password;
  bool _isshowen = false;
  void _setLoading(bool value) {
    _isshowen = value;
    setState(() {});
  }

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isshowen,
      child: Scaffold(
        backgroundColor: Color(kPimaryColor),
        body: Form(
          key: formkey,
          child: Column(
            children: [
              Spacer(flex: 2),
              Text(
                'ManageMate',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              Spacer(flex: 1),
              Customtext(
                hinttext: 'enter email',
                icon: Icon(Icons.email),
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'Required feild';
                  }
                },
                onChanged: (value) {
                  _emailAddress = value;
                },
              ),
              SizedBox(height: 10),
              Customtext(
                hinttext: 'enter password',
                icon: Icon(Icons.lock),
                validator: (data) {
                  if (data == null || data.isEmpty) {
                    return 'Required feild';
                  }
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 30),
              Custombutton(
                text: 'Sign Up',
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                onClick: () async {
                  if (!formkey.currentState!.validate()) return;
                  _setLoading(true);
                  try {
                  await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: _emailAddress!,
                          password: _password!,
                        );
                    await Usersservices.getCurrentLogedInUSer(_emailAddress!);
                    Helperfunctions.showSnackBar(
                      context,
                      'LogIn Succefully',
                      Colors.green,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                      (Route<dynamic> route) => false,
                    );
                  } on FirebaseAuthException catch (e) {
                    _setLoading(false);
                    if (e.code == 'user-not-found') {
                      Helperfunctions.showSnackBar(
                        context,
                        'No user found for that email.',
                        Colors.red,
                      );
                    } else if (e.code == 'wrong-password') {
                      Helperfunctions.showSnackBar(
                        context,
                        'Wrong password provided for that user.',
                        Colors.red,
                      );
                    }
                  } catch (e) {
                    _setLoading(false);
                    Helperfunctions.showSnackBar(
                      context,
                      'Error : $e',
                      Colors.red,
                    );
                  }
                  if (_isshowen) {
                    _setLoading(false);
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Registerpage.id);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
