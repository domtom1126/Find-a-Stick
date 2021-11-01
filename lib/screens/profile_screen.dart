import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/main.dart';
import 'package:find_stick/screens/auth_screen.dart';
import 'package:find_stick/screens/edit_profile_screen.dart';
import 'package:find_stick/screens/settings_screen.dart';
import 'package:find_stick/screens/user_listings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // show bottom modal sheet
                showModalBottomSheet(
                  context: context,
                  builder: (context) => EditProfile(),
                );
              }),
        ],
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                width: 100,
                // Use CircleAvatar for profile image
                child: Placeholder(
                  fallbackHeight: 25,
                  fallbackWidth: 25,
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 250,
                child: CupertinoButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.orangeAccent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserListings()));
                  },
                  child: Text('Your Listings'),
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 250,
                child: CupertinoButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.orangeAccent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                  },
                  child: Text('Settings'),
                ),
              ),
              new Expanded(
                child: Divider(
                  color: Colors.blueGrey,
                ),
              ),
              new Container(
                child: MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authentication()));
                  },
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
