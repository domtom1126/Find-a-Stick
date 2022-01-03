import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/screens/each_car.dart';
import 'package:find_stick/screens/form_screen.dart';
import 'package:find_stick/screens/user_messages.dart';
// import 'package:find_stick/widgets/image_gallery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ListViewCars extends StatefulWidget {
  const ListViewCars({Key? key}) : super(key: key);

  @override
  _ListViewCarsState createState() => _ListViewCarsState();
}

class _ListViewCarsState extends State<ListViewCars> {
  final scrollController = ScrollController();
  Set<String> _favCars = Set<String>();
  // FirebaseStorage imageList = FirebaseStorage.instance;
  final images = FirebaseStorage.instance.ref().child('images');
  final cars = FirebaseFirestore.instance
      .collection('publicCars')
      .orderBy('dateAdded', descending: true)
      .snapshots();
  // variable for liked button state
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // * Original appbar at the bottom
      appBar: AppBar(
        actions: [
          IconButton(
            // color: Colors.white,
            icon: Icon(Icons.search),
            onPressed: () {
              // This needs to go to the search page
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text('Search'),
                      ),
                    );
                  });
            },
          ),
        ],
        bottom: PreferredSize(
          child: Container(
            color: HexColor('E07619'),
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: Text('Find Stick'),
      ),
      body: StreamBuilder(
          stream: cars,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.only(top: 10),
                children: snapshot.data!.docs.map((publicCar) {
                  // * This is for each posting
                  return ListTile(
                    onTap: //* This is for each posting
                        () {
                      print('${publicCar['make']}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleListingInfo(
                            make: '${publicCar['make']}',
                            model: '${publicCar['model']}',
                            year: '${publicCar['year']}',
                            trim: '${publicCar['trim']}',
                            miles: '${publicCar['miles']}',
                            price: '${publicCar['price']}',
                            description: '${publicCar['description']}',
                          ),
                        ),
                      );
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Placeholder(
                          fallbackHeight: 250,
                        ),
                        //CarouselSlider
                        // CarouselSlider(
                        //   options: CarouselOptions(
                        //     height: 200,
                        //     autoPlay: true,
                        //     enlargeCenterPage: true,
                        //     aspectRatio: 2.0,
                        //     viewportFraction: 0.9,
                        //     initialPage: 0,
                        //     enableInfiniteScroll: true,
                        //     reverse: false,
                        //     autoPlayInterval: Duration(seconds: 3),
                        //     autoPlayAnimationDuration:
                        //         Duration(milliseconds: 800),
                        //     autoPlayCurve: Curves.fastOutSlowIn,
                        //     scrollDirection: Axis.horizontal,
                        //   ),
                        //   items: publicCar['images']
                        //       .map<Widget>((url) => Container(
                        //             width: MediaQuery.of(context).size.width,
                        //             margin:
                        //                 EdgeInsets.symmetric(horizontal: 5.0),
                        //             decoration: BoxDecoration(
                        //               color: Colors.grey,
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(10),
                        //               child: Image.network(
                        //                 url,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ))
                        //       .toList(),
                        // ),
                        Text(
                          '${publicCar['make']} ${publicCar['model']} ${publicCar['trim']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('${publicCar['price']}')
                      ],
                    ),
                    subtitle: Text(
                        '${publicCar['year']} | ${publicCar['miles']} Miles'),
                    // trailing: // Like button to change color on click
                    //     IconButton(
                    //   icon: Icon(
                    //     isLiked ? Icons.favorite : Icons.favorite_border,
                    //     color: isLiked ? Colors.red : Colors.black45,
                    //   ),
                    //   onPressed: () {
                    //     setState(() {});
                    //   },
                    // ),
                  );
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

// * for like button
  Future<void> likedCar() async {
    null;
  }
}
// import 'dart:convert';

// // import 'package:coingecko_dart/coingecko_dart.dart';
// // import 'package:coingecko_dart/dataClasses/coins/Coin.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:find_stick/screens/each_car.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AddCoin extends StatefulWidget {
//   const AddCoin({Key? key}) : super(key: key);

//   @override
//   _AddCoinState createState() => _AddCoinState();
// }

// // CoinGeckoApi apiInstance = CoinGeckoApi();

// class _AddCoinState extends State<AddCoin> {
//   Set<String> _favCars = Set<String>();
//   // final images = FirebaseStorage.instance.ref().child('images');
//   final cars = FirebaseFirestore.instance
//       .collection('publicCars')
//       .orderBy('dateAdded', descending: true)
//       .snapshots();
//   // variable for liked button state
//   bool isLiked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // * Original appbar at the bottom
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // This needs to go to the search page
//               showModalBottomSheet(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return SafeArea(
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text('Search'),
//                       ),
//                     );
//                   });
//             },
//           ),
//         ],
//         title: Text('Find Stick'),
//       ),
//       body: StreamBuilder(
//           stream: cars,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasData) {
//               return ListView(
//                 children: snapshot.data!.docs.map((publicCar) {
//                   // * This is for each posting
//                   return ListTile(
//                     onTap: //* This is for each posting
//                         () {
//                       print('${publicCar['make']}');
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SingleListingInfo(
//                             make: '${publicCar['make']}',
//                             model: '${publicCar['model']}',
//                             year: '${publicCar['year']}',
//                             trim: '${publicCar['trim']}',
//                             miles: '${publicCar['miles']}',
//                           ),
//                         ),
//                       );
//                     },
//                     title: Column(
//                       children: [
//                         Text(
//                           '${publicCar['make']} ${publicCar['model']} ${publicCar['trim']}',
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                       ],
//                     ),
//                     subtitle: Text(
//                         '${publicCar['year']} | ${publicCar['miles']} Miles'),
//                     trailing: // Like button to change color on click
//                         IconButton(
//                       icon: Icon(
//                         isLiked ? Icons.favorite : Icons.favorite_border,
//                         color: isLiked ? Colors.red : Colors.white,
//                       ),
//                       onPressed: () {
//                         setState(() {});
//                       },
//                     ),
//                   );
//                 }).toList(),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           }),
//     );
//   }

// // * for like button
//   Future<void> likedCar() async {
//     null;
//   }
// }

// AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(Icons.message),
//           onPressed: () {
//             // navigator material route
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UserMessages(),
//               ),
//             );
//           },
//         ),
//         title: Padding(
//             padding: EdgeInsets.only(left: 16, right: 16),
//             child: Text(
//               'Listings',
//             )),
//       ),

