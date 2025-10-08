import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:teamtasks/Config/HelperFunctions.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Widgets/CustomText.dart';
import 'package:teamtasks/models/ProjectModal.dart';

class Addnewprojects extends StatefulWidget {
  Addnewprojects({super.key, required this.context});
  final BuildContext context;

  @override
  State<Addnewprojects> createState() => _AddnewprojectsState();
}

class _AddnewprojectsState extends State<Addnewprojects> {
  String? _name;

  String? _githublink;

  void _save() async {
    if (!formstate.currentState!.validate()) return;

    try {
      _setLoading(true);
      bool isexists = await Projectsservice.isThisNameToken(
        _name!,
        logedinUser!.id,
      );
      if (isexists) {
        _setLoading(false);
        Helperfunctions.showSnackBar(
          widget.context,
          'this name already exist',
          Colors.red,
        );
        return;
      }

      await Projectsservice.AddProject(
        Projectmodal(
          adminID: logedinUser!.id,
          createdDatefeild: DateTime.now(),
          githubLink: _githublink!,
          iD: 'noID',
          projectName: _name!,
          status: EnProjectStatus.fresh.index,
          adminName: logedinUser!.firstName + ' ' + logedinUser!.lastNameName,
          runingTasks: 0,
        ),
      );
      Helperfunctions.showSnackBar(
        widget.context,
        'Project $_name added succefully make sur $_githublink exist system will validate',
        Colors.green,
      );
      _setLoading(false);
      Navigator.pop(widget.context);
    } catch (e) {
      _setLoading(false);
      Helperfunctions.showSnackBar(widget.context, 'Error $e', Colors.red);
      print('$e');
    }
    if (_showLoading) {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    setState(() {
      _showLoading = value;
    });
  }

  bool _showLoading = false;
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      child: SizedBox(
        height: 270,
        width: 300,
        child: Form(
          key: formstate,
          child: ModalProgressHUD(
            inAsyncCall: _showLoading,
            child: Column(
              children: [
                Customtext(
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'this feild required';
                    }
                    return null;
                  },
                  onChanged: (data) {
                    _name = data;
                  },
                  hinttext: 'Project Name',
                  icon: Icon(Icons.text_format),
                ),
                SizedBox(height: 20),
                Customtext(
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'this feild required';
                    }
                    if (!data.startsWith('https://github.com/') &&
                        !data.startsWith('http://github.com/')) {
                      return 'all github Rep start with : https://github.com/ ';
                    }

                    return null;
                  },
                  onChanged: (data) {
                    _githublink = data;
                  },
                  hinttext: 'Project GitHub Rep',
                  icon: Icon(FontAwesomeIcons.github),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
