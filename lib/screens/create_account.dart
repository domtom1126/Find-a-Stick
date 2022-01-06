import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/services/auth.dart';
import 'package:find_stick/services/database.dart';
import 'package:find_stick/widgets/user_picked_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  List<XFile>? _imageFileList;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController inputUsername = new TextEditingController();
  final TextEditingController inputEmail = new TextEditingController();
  final TextEditingController inputPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // 3 text form fields
            TextFormField(
              controller: inputUsername,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: inputEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: inputPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: // imagepicker
                  () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() {
                    _imageFileList = [XFile(pickedFile.path)];
                  });
                }
                // todo upload image to firebase (shared preferences)
              },
              child: Text('Choose Profile Picture'),
            ),
            SizedBox(
              height: 75,
            ),
            ElevatedButton(
              onPressed: () async {
                // check if all fields are filled
                if (inputUsername.text.isEmpty ||
                    inputEmail.text.isEmpty ||
                    inputPassword.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error',
                            style: TextStyle(color: Colors.white)),
                        content: Text('Please fill all fields'),
                        actions: [
                          ElevatedButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  register(inputEmail.text, inputPassword.text,
                      inputUsername.text, 'downloadUrl');
                  // navigate to home page
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
