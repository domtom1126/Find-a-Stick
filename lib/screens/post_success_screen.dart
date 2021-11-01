import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_stick/widgets/car_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'form_screen.dart' as sliderImages;

class PostSuccess extends StatelessWidget {
  const PostSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Column(children: [
        // Container(
        //       child: CarouselSlider.builder(
        //         itemCount: imageList!.length.toInt(),
        //         itemBuilder: (BuildContext context, int index,
        //                 int pageViewIndex) =>
        //             Container(child: Image.file(File(imageList![index].path))),
        //         options: CarouselOptions(viewportFraction: 0.75),
        //       ),
        //     ),
        Text('This is gonna be car data'),
        CupertinoButton(
            child: Text('Go to listings'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CarList()));
            })
      ]),
    );
  }
}
