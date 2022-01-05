import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<void> pickSingleImage() async {
  FirebaseStorage storageReference = FirebaseStorage.instance;

  // List<XFile>? pickedImage = (await ImagePicker().pickMultiImage(
  //   maxWidth: 100,
  //   maxHeight: 100,
  // ));
  // XFile image = pickedImage![0];
  // // * add images to firebase_storage after picking
  // for (var i = 0; i < pickedImage!.length; i++) {
  //   Reference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('images/${pickedImage[i].path.split('/').last}');
  //   File imageFile = File(pickedImage[i].path);
  //   // * This is what uploads to firebase storage
  //   // UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
  //   try {
  //     await storageReference.putFile(imageFile);
  //   } catch (e) {
  //     print(e);
  //   }
  //   // * Downloads the URL and displays it in the carousel_slider
  //   var imageUrl = await (await uploadTask).ref.getDownloadURL();
  //   var url = imageUrl.toString();
  //   setState(() {
  //   // show image on screen after picking
  //   imageList!.addAll([XFile(length: url)]);
  //   });
  // }
  // return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Success'),
  //         content: Text('Image uploaded'),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       );
  //     });

  // select single image
  final picker = ImagePicker();
  try {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final String fileName = pickedFile!.path;
    print(fileName);

    // try {
    //   await storageReference.putFile(imageFile);
    // } catch (e) {
    //   print(e);
    // }
  } catch (e) {
    print(e);
  }
}
