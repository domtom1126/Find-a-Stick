// Appears after auth screen, basically the home screeen
import 'package:find_stick/screens/liked_screen.dart';
import 'package:find_stick/screens/messages_screen.dart';
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
    Container(child: ListViewCars()),
    Container(child: PostScreen()),
    Container(child: Text('chat')),
    Container(child: Text('profile')),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Car List'),
            // todo navigate to messages page
            actions: [IconButton(onPressed: null, icon: Icon(Icons.message))],
          ),
          body: _children[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueGrey,
            onTap: _onItemTap,
            currentIndex: _selectedIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.hdr_plus),
                label: 'Cars',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.hdr_plus),
                label: 'Post',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.message_sharp),
                label: 'Liked',
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          ),
        ),
      ),
    );
  }
}
