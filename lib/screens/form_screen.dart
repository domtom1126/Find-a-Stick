import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:find_stick/screens/post_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recase/recase.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  PostForm({Key? key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // * Global Vars
  var showYear = '';
  var showMake = '';
  var showModel = '';
  var showTrim = '';
  var showSeries = '';

// * instance

  final TextEditingController inputYear = new TextEditingController();
  final TextEditingController vinNumber = new TextEditingController();
  final TextEditingController inputMiles = new TextEditingController();
  final TextEditingController inputPrice = TextEditingController();
  final TextEditingController inputDescription = TextEditingController();
// * Global form key
  final _formKey = GlobalKey<FormState>();
  List<XFile>? imageList = [];
  File? singleImage;
  List<String> downloadedUrls = [];
  // * For picking multiple photos

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            // * Enter vin number
            TextFormField(
              onChanged: (val) {
                // sends vin number in all Caps
                val = vinNumber.text.toUpperCase();
              },
              textCapitalization: TextCapitalization.characters,
              controller: vinNumber,
              decoration: new InputDecoration(
                  labelText: 'VIN Number',
                  labelStyle: TextStyle(color: Colors.white70)),
            ),
            SizedBox(height: 20),
            // * This is for input year
            TextFormField(
              onChanged: (val) {
                val = inputYear.text;
              },
              controller: inputYear,
              decoration: new InputDecoration(
                  labelText: 'Model Year',
                  labelStyle: TextStyle(color: Colors.white70)),
            ),
            SizedBox(height: 20),
            TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter(symbol: '', decimalDigits: 0)
                ],
                onChanged: (val) {
                  val = inputMiles.text;
                },
                decoration: new InputDecoration(
                    labelText: 'Miles',
                    labelStyle: TextStyle(color: Colors.white70)),
                controller: inputMiles),
            SizedBox(height: 20),
            TextFormField(
                inputFormatters: [
                  CurrencyTextInputFormatter(symbol: '\$', decimalDigits: 0)
                ],
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  val = inputPrice.text;
                },
                decoration: new InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: Colors.white70)),
                controller: inputPrice),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (val) {
                val = inputDescription.text;
              },
              controller: inputDescription,
              maxLines: 5,
              decoration: new InputDecoration(
                labelText: 'Vehicle Description',
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: CupertinoButton(
                color: Colors.orangeAccent,
                onPressed: () async {
                  uploadFiles();
                },
                child: Text('Add Photo'),
              ),
            ),
            // SizedBox(height: 20),
            // container to show image from imageList
            Container(
              height: 200,
              child: downloadedUrls.length == 0
                  ? Center(
                      child: Text('No images selected'),
                    )
                  : CarouselSlider(
                      items: downloadedUrls.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 1.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Image.file(File(i.toString()),
                                  fit: BoxFit.cover),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 150,
                        // aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
            ),
            SizedBox(
              width: 250,
              child: CupertinoButton(
                color: Colors.orangeAccent,
                onPressed: () => vinSearch(vinNumber, inputYear),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> vinSearch(vin, year) async {
    // check if text fiels are empty
    if (vin.text.isEmpty || year.text.isEmpty) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please fill in all fields'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    CollectionReference publicCars =
        FirebaseFirestore.instance.collection('publicCars');
    var url = Uri.parse(
        'https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVINValues/${vin.text}?format=json&modelyear=$year.text');
    var response = await http.get(url);
    String data = response.body;
    // * Gets the data from url. this data needs to go into firestore for user.
    var make = jsonDecode(data)['Results'][0]['Make'];
    var model = jsonDecode(data)['Results'][0]['Model'];
    var jsonYear = jsonDecode(data)['Results'][0]['ModelYear'];
    var trim = jsonDecode(data)['Results'][0]['Trim'];
    var series = jsonDecode(data)['Results'][0]['Series'];
    User? user = auth.currentUser;
    final userUid = user!.uid;
    setState(() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.blueGrey,
          context: context,
          builder: (context) {
            return Column(children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'Is This Your Car?',
                  style: TextStyle(fontSize: 40, fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text.rich(TextSpan(children: <TextSpan>[
                // year is coming from text controller not json value
                TextSpan(text: '$jsonYear ', style: TextStyle(fontSize: 20)),
                TextSpan(
                    text: ' $make '.titleCase,
                    style: TextStyle(
                      fontSize: 20,
                    )),
                TextSpan(text: ' $model ', style: TextStyle(fontSize: 20)),
                TextSpan(text: '$trim ', style: TextStyle(fontSize: 20)),
                TextSpan(
                    text: 'Miles: ${inputMiles.text}',
                    style: TextStyle(fontSize: 20)),
              ])),
              CarouselSlider.builder(
                itemCount: downloadedUrls.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  if (downloadedUrls.isNotEmpty) {
                    return Container(
                        child: Image.file(File(downloadedUrls[index])));
                  } else {
                    return Container(child: Text('hwllo'));
                  }
                },
                options: CarouselOptions(viewportFraction: 0.75),
              ),
              // Text('$model, $trim'),
              // * Posts to firebase
              CupertinoButton(
                  color: Colors.orangeAccent,
                  child: Text('Add Car'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // firebase stuff
                      publicCars.add({
                        'year': jsonYear,
                        'make': make,
                        'model': model,
                        'trim': trim,
                        'series': series,
                        'miles': inputMiles.text,
                        'price': inputPrice.text,
                        'dateAdded': DateTime.now(),
                        'userID': userUid,
                        'description': inputDescription.text,
                        // this is for storing images it stores the path and kinda works but doesnt work across devices
                        // 'images': imageList!.map((i) {
                        //   return i.path;
                        // }).toList(),
                      });
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostSuccess()));
                  })
            ]);
          });
    });
  }

  Future pickImage() async {
    List<XFile>? pickedimageList = await ImagePicker().pickMultiImage(
      maxWidth: 160,
      maxHeight: 160,
    );
    imageList!.addAll(pickedimageList!);
    setState(() {
      Builder(builder: (context) {
        return Container(child: Text('Photos Added'));
      });
    });
  }

  @override
  void dispose() {
    inputYear.dispose();
    inputMiles.dispose();
    vinNumber.dispose();
    super.dispose();
  }

  // * This is for picking a single photo
  Future<void> pickSingleImage() async {
    List<XFile>? pickedImage = await ImagePicker().pickMultiImage(
      maxWidth: 100,
      maxHeight: 100,
    );
    var imageUrls = imageList!.map((i) {
      return i.path;
    }).toList();
    setState(() {
      // show image on screen after picking
      imageList!.addAll(pickedImage!);
    });
  }

  Future<List<String>> uploadFiles() async {
    List<XFile>? pickedImage = await ImagePicker().pickMultiImage(
      maxWidth: 100,
      maxHeight: 100,
    );
    List<String> urls = [];
    for (var file in pickedImage!) {
      XFile url = (file);
      urls.add(url.path);
      Reference reference = FirebaseStorage.instance.ref().child('images/');
      for (var image in urls) {
        await reference.putFile(File(image));
        String downloadUrl = await reference.getDownloadURL();
        downloadedUrls.add(downloadUrl);
        print(downloadedUrls);
      }
    }
    return urls;
  }

  // Future<String> uploadFile(File file) async {
  //   String filePath = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //   Reference reference = FirebaseStorage.instance.ref().child(filePath);
  //   UploadTask uploadTask = reference.putFile(file);
  //   uploadTask.then((res) {
  //     res.ref.getDownloadURL();
  //   });
  //   return filePath;
  // }
}
