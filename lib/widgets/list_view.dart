import 'package:find_stick/screens/liked_screen.dart';
import 'package:find_stick/screens/post_screen.dart';
import 'package:find_stick/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ListViewCars extends StatefulWidget {
  const ListViewCars({Key? key}) : super(key: key);

  @override
  _ListViewCarsState createState() => _ListViewCarsState();
}

class _ListViewCarsState extends State<ListViewCars> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
            100,
            (index) {
              return Column(
                children: [
                  //  ? Scrollable gallery click to expand
                  Row(
                    children: [Text('gallery of car here')],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: null, icon: Icon(Icons.favorite)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Year ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Brand ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Price '),
                      Text('Miles'),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
