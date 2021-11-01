import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserListings extends StatefulWidget {
  const UserListings({Key? key}) : super(key: key);

  @override
  _UserListingsState createState() => _UserListingsState();
}

class _UserListingsState extends State<UserListings> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    final userUid = user!.uid;
    final userCars = FirebaseFirestore.instance
        .collection('publicCars')
        .where('userID', isEqualTo: userUid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(title: Text('Your Cars')),
      body: StreamBuilder(
          stream: userCars,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((publicCar) {
                  return ListTile(
                    onTap: null,
                    // * This is for each posting

                    title: Text(
                      '${publicCar['make']} ${publicCar['model']} ${publicCar['trim']}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text(
                        '${publicCar['year']} | ${publicCar['miles']} Miles'),
                    // trailing: LikeButton(),
                  );
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
