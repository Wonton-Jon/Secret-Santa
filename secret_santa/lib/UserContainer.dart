import 'package:flutter/material.dart';

enum TEXTFIELD_ID { NAME, EMAIL }

class UserData {
  String? name; //User's name
  String? email;//User's email 
  TextEditingController _nameController = TextEditingController(); //Controller for name text field
  TextEditingController _emailController = TextEditingController(); //Controller for email text field

  //Create text field for the name and email
  TextField? nameTextField = TextField(
                              onChanged: (value) {
                                print('vlaue is $value');
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter person\'s name.',
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                ),
                              ),
                            );
  TextField? emailTextField = TextField(
                              onChanged: (value) {
                                print('vlaue is $value');
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter person\'s email.',
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                ),
                              ),
                            );

  UserData({this.name, this.email, this.nameTextField, this.emailTextField});

  //Get the user data from the text fields
  Future getUserData() async {
    name = _nameController.text.trim();
    email = _emailController.text.trim();
  }
}
