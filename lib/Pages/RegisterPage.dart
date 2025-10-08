import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Config/ValidationString.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Pages/HomePage.dart';
import 'package:teamtasks/Services/UsersServices.dart';
import 'package:teamtasks/Widgets/CustomButton.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/models/UserModal.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});
  static const id = 'Registerpage';

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final GlobalKey<FormState> formkey = GlobalKey();

  String? _firstName;

  String? _lastNameName;

  String? _email;

  String? _password;

  String? _confirmpassword;
  bool _isshowen = false;

  void _setLoading(bool value) {
    _isshowen = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isshowen,
      child: Scaffold(
        backgroundColor: Color(kPimaryColor),
        body: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'ManageMate',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Row(
                  children: [
                    Expanded(
                      child: Customtext(
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'required feild';
                          }
                        },
                        onChanged: (value) {
                          _firstName = value;
                        },
                        hinttext: 'first name',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    Expanded(
                      child: Customtext(
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'required feild';
                          }
                        },
                        hinttext: 'last  name',
                        onChanged: (value) {
                          _lastNameName = value;
                        },
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Customtext(
                  hinttext: 'Email',
                  onChanged: (value) {
                    _email = value;
                  },
                  icon: Icon(Icons.email),
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'required feild';
                    }
                    if (!Validationstring.isValidEmail(data)) {
                      return 'Enter a valid email address';
                    }
                  },
                ),
                SizedBox(height: 20),
                Customtext(
                  hinttext: 'Password',
                  onChanged: (value) {
                    _password = value;
                  },
                  icon: Icon(Icons.lock),
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'required feild';
                    }
                    if (data.length < 8) {
                      return 'Password length must be greater than 7';
                    }
                  },
                ),
                SizedBox(height: 20),
                Customtext(
                  hinttext: 'Confirm Password',
                  onChanged: (value) {
                    _confirmpassword = value;
                  },
                  icon: Icon(Icons.lock),
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'required feild';
                    }
                    if (data != _password) {
                      return 'Passwords do not match!';
                    }
                  },
                ),
                SizedBox(height: 30),
                Custombutton(
                  text: 'Sign In',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  onClick: () async {
                    if (!formkey.currentState!.validate()) return;
                    _setLoading(true);
                    try {
                      await Usersservices.saveUser(
                        Usermodal(
                          id: 'moo',
                          createdDate: DateTime.now(),
                          email: _email!,
                          firstName: _firstName!,
                          lastNameName: _lastNameName!,
                          statistics: 0,
                          password: _confirmpassword,
                        ),
                      );
                      Helperfunctions.showSnackBar(
                        context,
                        "User added successfully.",
                        Colors.green,
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                        (Route<dynamic> route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      _setLoading(false);
                      if (e.code == 'weak-password') {
                        Helperfunctions.showSnackBar(
                          context,
                          "The password provided is too weak.",
                          Colors.red,
                        );
                      } else if (e.code == 'email-already-in-use') {
                        Helperfunctions.showSnackBar(
                          context,
                          "The account already exists for that email.",
                          Colors.red,
                        );
                      } else {
                        Helperfunctions.showSnackBar(
                          context,
                          "Auth error: ${e.message}",
                          Colors.red,
                        );
                      }
                    } catch (e) {
                      _setLoading(false);
                      Helperfunctions.showSnackBar(
                        context,
                        "Error :  ${e.toString()}",
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
