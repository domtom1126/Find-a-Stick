// Appears after auth screen, basically the home screeen
import 'package:find_stick/screens/liked_screen.dart';
import 'package:find_stick/screens/messages_screen.dart';
import 'package:find_stick/screens/post_screen.dart';
import 'package:find_stick/screens/profile_screen.dart';
import 'package:find_stick/widgets/list_view.dart';
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
    Container(child: LikedScreen()),
    Container(child: ProfileScreen()),
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
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.blueGrey,
          //   // title: Text('Car List'),
          //   // todo navigate to messages page
          //   actions: [IconButton(onPressed: null, icon: Icon(Icons.message))],
          // ),
          // First page this navigates to is ListViewCars
          body: _children[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.orange[400],
            backgroundColor: Colors.black45,
            elevation: 0,
            onTap: _onItemTap,
            currentIndex: _selectedIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.directions_car_filled_outlined),
                label: 'Cars',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_rounded),
                label: 'Post',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Liked',
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
