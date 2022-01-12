import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<void> pickSingleImage() async {
  FirebaseStorage storageReference = FirebaseStorage.instance;

  // select single image
  final picker = ImagePicker();
  try {
    final List<XFile>? pickedFile = await picker.pickMultiImage();
    for (final XFile file in pickedFile!) {
      final String filePath = file.path;
      storageReference.ref().child(filePath);
      // await storageReference.ref().child(filePath).putFile(file);
      // final TaskSnapshot downloadUrl = (await uploadTask);
      // final String url = (await downloadUrl.ref.getDownloadURL());
      // print(url);
    }
    // * The .ref refers to the things already inside of 'images'
    // todo get downloadUrl for each image and store it in the post with the car
    String downloadUrl = await storageReference.ref('images/').getDownloadURL();
    print(downloadUrl);

    // print(pickedFile);
  } catch (e) {
    print(e);
  }
}

Future<void> uploadProfilePicture() async {
  final picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
  );
  // pickedFile needs to upload to firebase
  XFile file = XFile(pickedFile!.path);
  await _storage
      .ref('/user_pictures/$file')
      .child(file.toString())
      .putFile(File(pickedFile.path));

  // get downloadUrl
  String downloadedImage =
      await _storage.ref('/user_pictures/$file').getDownloadURL();
  print(downloadedImage);
  // store downloadUrl in shared preferences

  // todo upload image to firebase (shared preferences)
}
