import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_stick/screens/user_messages.dart';
import 'package:find_stick/widgets/bottom_bar.dart';
import 'package:find_stick/widgets/list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'form_screen.dart' as sliderImages;

class PostSuccess extends StatefulWidget {
  // const PostSuccess({Key? key}) : super(key: key);
  var make;
  var model;
  var year;
  var trim;
  var series;
  var miles;
  var price;
  var images;
  var description;

  PostSuccess(
      {Key? key,
      this.make,
      this.model,
      this.year,
      this.trim,
      this.miles,
      this.price,
      this.description,
      series,
      required List<String> images})
      : super(key: key);

  @override
  State<PostSuccess> createState() => _PostSuccessState();
}

class _PostSuccessState extends State<PostSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Post'),
      ),
      body: ListView(children: [
        Column(
          children: <Widget>[
            // CarouselSlider
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                // pauseAutoPlayOnTouch: Duration(seconds: 10),
              ),
              items: widget.images.map((url) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 10),
                title: Text(
                  '${widget.price}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 10),
                title: Text(
                  '${widget.make} ${widget.model} ${widget.year} ${widget.trim}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${widget.miles} Miles',
                    style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10,
                bottom: 25,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.description}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            // button at bottom of page
            Align(
              heightFactor: 4,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
                child: const Text('Confirm Post'),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
