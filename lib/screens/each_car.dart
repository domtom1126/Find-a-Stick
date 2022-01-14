import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_stick/screens/user_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleListingInfo extends StatefulWidget {
  var make;
  var model;
  var year;
  var trim;
  var miles;
  var price;
  var description;

  SingleListingInfo(
      {Key? key,
      this.make,
      this.model,
      this.year,
      this.trim,
      this.miles,
      this.price,
      this.description})
      : super(key: key);

  @override
  State<SingleListingInfo> createState() => _SingleListingInfoState();
}

class _SingleListingInfoState extends State<SingleListingInfo> {
  List<bool> _likes = List.filled(1, true);
  String _emailUrl =
      'mailto:domtom1126@gmail.com?subject=Id like to know more about your car! &body=This is the body';
  String _textUrl = 'sms:<phone number>';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listing Info'),
        ),
        body: ListView(
          children: [
            Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(10),
                    child: Placeholder(fallbackHeight: 250)),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      '${widget.price}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 10),
                    title: Text(
                      '${widget.year} ${widget.make} ${widget.model} ${widget.trim}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${widget.miles} Miles',
                        style: TextStyle(fontSize: 15)),
                    trailing: // Like button to change color on click
                        IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.favorite),
                      color: _likes[0] ? Colors.grey : Colors.red,
                      onPressed: () {
                        setState(() {
                          _likes[0] = !_likes[0];
                        });
                      },
                    ),
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
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Send email button
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        child: Text(
                          'Send Email',
                        ),
                        onPressed: () => _launchEmail(),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        child: Text(
                          'Send Text',
                        ),
                        onPressed: () => _launchText(),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  void _launchEmail() async {
    if (!await launch(_emailUrl)) throw 'Could not launch $_emailUrl';
  }

  void _launchText() async {
    if (!await launch(_textUrl)) throw 'Could not launch $_textUrl';
  }
}
