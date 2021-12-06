import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/screens/each_car.dart';
import 'package:find_stick/screens/user_messages.dart';
import 'package:find_stick/widgets/image_gallery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ListViewCars extends StatefulWidget {
  const ListViewCars({Key? key}) : super(key: key);

  @override
  _ListViewCarsState createState() => _ListViewCarsState();
}

class _ListViewCarsState extends State<ListViewCars> {
  final scrollController = ScrollController();
  Set<String> _favCars = Set<String>();
  // final images = FirebaseStorage.instance.ref().child('images');
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
        title: Text('Find Stick'),
      ),
      body: StreamBuilder(
          stream: cars,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
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
                          ),
                        ),
                      );
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${publicCar['make']} ${publicCar['model']} ${publicCar['trim']}',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ],
                    ),
                    subtitle: Text(
                        '${publicCar['year']} | ${publicCar['miles']} Miles'),
                    trailing: // Like button to change color on click
                        IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
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
