import 'package:find_stick/screens/user_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleListingInfo extends StatelessWidget {
  var make;
  var model;
  var year;
  var trim;
  var miles;

  SingleListingInfo(
      {Key? key, this.make, this.model, this.year, this.trim, this.miles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listing Info'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Placeholder(fallbackHeight: 100),
            ListTile(
              title: Text('$year $make $model $trim'),
              subtitle: Text('$miles Miles'),
            ),
            Expanded(
              child: Divider(
                color: Colors.blueGrey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: // on pressed show bottom modal for 10 seconds that shows you added to liked List
                        () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Added to Liked List',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(height: 25),
                                  // add button to remove from liked list
                                  CupertinoButton(
                                    color: Colors.red,
                                    onPressed: () {},
                                    child: Text('Remove from list'),
                                  ),
                                  SizedBox(height: 25),
                                ],
                              ),
                            );
                          });
                    },
                    child: Text('Like'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //navigate to user messages
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserMessages()),
                      );
                    },
                    child: Text('Message'),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
