import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_stick/widgets/image_gallery.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  _LikedScreenState createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  final imageList = [
    'http://wallup.net/wp-content/uploads/2016/01/272941-Dodge_Viper-car-sports_car-orange.jpg',
    'https://pictures.topspeed.com/IMG/crop/202011/cool-car-for-sale-20-5_1600x0w.jpg',
    'https://wallup.net/wp-content/uploads/2016/01/136864-orange_cars-car-BMW.jpg',
  ];
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
        title: Text('Liked'),
      ),
      // Todo This is where the liked widget should go
      body: null,
    );
  }
}
