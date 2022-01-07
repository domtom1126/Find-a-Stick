import 'dart:convert';
import 'dart:io';
import 'package:find_stick/widgets/user_picked_image.dart';
import 'package:find_stick/widgets/vin_search.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:find_stick/screens/post_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recase/recase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:basic_utils/basic_utils.dart';

class PostForm extends StatefulWidget {
  PostForm({Key? key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
  final TextEditingController make = TextEditingController();
// * Global form key
  final _formKey = GlobalKey<FormState>();
  List<XFile>? imageList = [];
  File? singleImage;
  // * For picking multiple photos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: HexColor('E07619'),
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: Text('Post a Car'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
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
                ),
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
                ),
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
                  ),
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
                  ),
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
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    pickSingleImage();
                  },
                  child: Text('Add Photo'),
                ),
              ),
              // SizedBox(height: 20),
              // container to show image from imageList
              Container(
                height: 200,
                child: imageList!.length == 0
                    ? Center(
                        child: Text('No images selected'),
                      )
                    : CarouselSlider(
                        items: imageList!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 1.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child:
                                    Image.file(File(i.path), fit: BoxFit.cover),
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
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (vinNumber.text.isEmpty || inputYear.text.isEmpty) {
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
                      } else if (vinNumber.text.length != 17) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Check the VIN number'),
                                content:
                                    Text('VIN needs to be 17 characters long'),
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
                      } else if (inputYear.text.length != 4) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Check the year'),
                                content:
                                    Text('Year needs to be 4 characters long'),
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
                      } else {
                        vinSearch(vinNumber, inputYear);
                      }
                    },
                    child: Text('Next'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> vinSearch(vin, year) async {
    CollectionReference publicCars =
        FirebaseFirestore.instance.collection('publicCars');

    var url = Uri.parse(
        'https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVINValues/${vin.text}?format=json&modelyear=${year.text}');
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
    bool isLiked = false;
    setState(() {
      showModalBottomSheet(
          backgroundColor: HexColor('474747'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // backgroundColor: Colors.blueGrey,
          context: context,
          builder: (context) {
            return Container(
              margin: EdgeInsets.all(20),
              child: ListView(children: [
                Text(
                  'Is This Your Car?',
                  style: TextStyle(
                      fontSize: 40, fontFamily: 'Roboto', color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Make sure everything is correct',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: HexColor('CCCCCC'),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Text('Vin Number', style: TextStyle(fontSize: 20, height: 3)),
                TextFormField(
                  onChanged: (val) {
                    val = vin.text;
                  },
                  controller: vin,
                ),
                Text('Year',
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                    )),
                TextFormField(
                  onChanged: (val) {
                    val = year.text;
                  },
                  controller: year,
                ),
                Text('Make', style: TextStyle(fontSize: 20, height: 2)),
                TextFormField(
                  initialValue: StringUtils.capitalize('$make'),
                ),
                Text('Model', style: TextStyle(fontSize: 20, height: 2)),
                TextFormField(
                  initialValue: '$model',
                ),
                Text('Trim', style: TextStyle(fontSize: 20, height: 2)),
                TextFormField(
                  initialValue: '$trim',
                ),
                Text('Series', style: TextStyle(fontSize: 20, height: 2)),
                TextFormField(
                  initialValue: '$series',
                ),

                Text('Images', style: TextStyle(fontSize: 20, height: 2)),
                CarouselSlider.builder(
                  itemCount: imageList!.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    if (imageList!.isNotEmpty) {
                      return Container(
                          child: Image.file(File(imageList![index].path)));
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
                          'make': StringUtils.capitalize(make),
                          'model': model,
                          'trim': trim,
                          'series': series,
                          'miles': inputMiles.text,
                          'price': inputPrice.text,
                          'dateAdded': DateTime.now(),
                          'userID': userUid,
                          'description': inputDescription.text,
                          'isLiked': isLiked,
                          'images': imageList!.map((i) {
                            return i.path;
                          }).toList(),
                        });
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostSuccess(
                            make: '$make',
                            model: '$model',
                            trim: '$trim',
                            series: series,
                            year: jsonYear,
                            miles: inputMiles.text,
                            price: inputPrice.text,
                            description: inputDescription.text,
                            // images: [
                            //   imageList![0].path,
                            //   imageList![1].path,
                            //   imageList![2].path,
                            //   imageList![3].path,
                            //   imageList![4].path,
                            // ],
                          ),
                        ),
                      );
                    })
              ]),
            );
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
}

// getImageUrl() async {
//   photoUrl = await FirebaseStorage.instance.ref().child('').getDownloadURL();
// }
