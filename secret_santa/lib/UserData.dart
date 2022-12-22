import 'package:flutter/material.dart';
import 'package:secret_santa/main.dart';

enum TEXTFIELD_ID { NAME, EMAIL }

class UserData {
  String? name; //User's name
  String? email; //User's email
  UserData? assignee; //Person that you are assigned to for secret santa
  TextEditingController _nameController =
      TextEditingController(); //Controller for name text field
  TextEditingController _emailController =
      TextEditingController(); //Controller for email text field

  //Create text field for the name and email
  TextField nameTextField = TextField();
  TextField emailTextField = TextField();

  //===========================================================================
  // CONSTRUCTOR
  //===========================================================================
  UserData({this.name, this.email});

  //===========================================================================
  // ACCESSORS
  //===========================================================================
  //Get the user data from the text fields
  Future getUserData() async {
    name = _nameController.text.trim();
    email = _emailController.text.trim();
  }

  Widget getContainer(int index) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        child: Column(
          children: [
            nameTextField = TextField(
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                print('vlaue is $value');
                name = _nameController.text.trim();
                print('name  is $name');
              },
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Santa #${index + 1}\'s name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor!, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor!, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            emailTextField = TextField(
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                print('calue is $value');
                email = _emailController.text.trim();
                print('email  is $email');
              },
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter Santa #${index + 1}\'s email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor!, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor!, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(0.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        width: 10,
        height: 100,
      ),
    );
  }

  //Get the object data as a string
  @override
  String toString() {
    StringBuffer string = StringBuffer();

    string.write('name:  $name\n');
    string.write('email: $email\n');
    string.write('assignee name: ${assignee!.name}\n\n');
    string.write('assignee email: ${assignee!.email}\n\n');

    return string.toString();
  }
}
