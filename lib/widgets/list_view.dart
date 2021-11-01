import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/screens/each_car.dart';
import 'package:find_stick/screens/user_messages.dart';
import 'package:find_stick/widgets/image_gallery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewCars extends StatefulWidget {
  const ListViewCars({Key? key}) : super(key: key);

  @override
  _ListViewCarsState createState() => _ListViewCarsState();
}

class _ListViewCarsState extends State<ListViewCars> {
  final cars = FirebaseFirestore.instance
      .collection('publicCars')
      .orderBy('dateAdded', descending: true)
      .snapshots();
  // variable for liked button state
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            // navigator material route
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserMessages(),
              ),
            );
          },
        ),
        title: Text('Listings'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: StreamBuilder(
              stream: cars,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          children: [
                            // map each image in carousel_slider
                            // CarouselSlider(
                            //     options: CarouselOptions(
                            //       height: 200,
                            //       aspectRatio: 16 / 9,
                            //       enlargeCenterPage: true,
                            //       viewportFraction: 0.9,
                            //       initialPage: 0,
                            //       enableInfiniteScroll: true,
                            //       reverse: false,
                            //       scrollDirection: Axis.horizontal,
                            //     ),
                            //     items: [
                            //       // * This is for each image in carousel_slider
                            //       for (var image in publicCar['images'])
                            //         Container(
                            //             width:
                            //                 MediaQuery.of(context).size.width,
                            //             margin: EdgeInsets.symmetric(
                            //                 horizontal: 5.0),
                            //             child: ClipRRect(
                            //                 borderRadius:
                            //                     BorderRadius.circular(8.0),
                            //                 child: Image.network(
                            //                   image,
                            //                   fit: BoxFit.cover,
                            //                 )))
                            //     ]),

                            Text(
                              '${publicCar['make']} ${publicCar['model']} ${publicCar['trim']}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        subtitle: Text(
                            '${publicCar['year']} | ${publicCar['miles']} Miles'),
                        trailing: // Like button to change color on click
                            IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

// * for like button
  Future<void> likedCar() async {
    null;
  }
}
