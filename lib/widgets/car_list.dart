import 'package:find_stick/screens/liked_screen.dart';
import 'package:find_stick/screens/post_screen.dart';
import 'package:find_stick/screens/profile_screen.dart';
import 'package:find_stick/widgets/list_view.dart';
import 'package:find_stick/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
  const CarList({Key? key}) : super(key: key);

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    // HomeScreen(),
    PostScreen(),
    LikedScreen(),
    ProfileScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Row(children: [
      Scaffold(
          appBar: AppBar(
            title: Text('Car List'),
          ),
          body: _children[_selectedIndex]
              child: ListViewCars()),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTap,
            currentIndex: _selectedIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.hdr_plus),
                label: 'Cars',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.message_sharp),
                label: 'Messages',
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          ))
    ]));
  }
}

// todo Make seperate class of this
GridView.count(
            crossAxisCount: 1,
            children: List.generate(100, (index) {
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
            }),
          )