import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference reference =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String name, String email, String profile_picture_url) async {
    return await reference.doc(uid).set({
      'email': email,
      'userId': uid,
      'name': name,
      'date_created': DateTime.now().toIso8601String().toString(),
      'profile_picture': profile_picture_url,
    });
  }

  // get users stream
  Stream<QuerySnapshot> get users {
    return reference.snapshots();
  }
}
