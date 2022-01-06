import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/main.dart';
import 'package:find_stick/screens/auth_screen.dart';
import 'package:find_stick/services/database.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
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
  final result = FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
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
                  builder: (context) => SettingsScreen(),
                );
              }),
        ],
        bottom: PreferredSize(
          child: Container(
            color: HexColor('E07619'),
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
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
              StreamBuilder<QuerySnapshot>(
                stream: result,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.docs.map((document) {
                        return ListTile(
                          title: Text(document['name'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center),
                          subtitle: Text(document['email'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center),
                        );
                      }).toList(),
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserListings()));
                },
                child: Text('Your Listings'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                child: Text('Settings'),
              ),
              new Expanded(
                child: Divider(),
              ),
              new Container(
                child: MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/');
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
