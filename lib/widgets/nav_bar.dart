import 'package:find_stick/screens/home_screen.dart';
import 'package:find_stick/screens/liked_screen.dart';
import 'package:find_stick/screens/post_screen.dart';
import 'package:find_stick/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
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
      child: Scaffold(
        body: _children[_selectedIndex],
        backgroundColor: Colors.blueGrey,
        bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}

// currentIndex: _selectedIndex,
// onTap: _onItemTap,
// elevation: 0.0,
// fixedColor: Colors.orange[300],
// backgroundColor: Colors.blueGrey,
//         unselectedItemColor: Colors.white60,
//         type: BottomNavigationBarType.fixed,

// BottomNavigationBar(
//           onTap: _onItemTap,
//           currentIndex: _selectedIndex,
//           items: [
//             new BottomNavigationBarItem(
//               icon: Icon(Icons.hdr_plus),
//               label: 'Cars',
//             ),
//             new BottomNavigationBarItem(
//               icon: Icon(Icons.message_sharp),
//               label: 'Messages',
//             ),
//             new BottomNavigationBarItem(
//                 icon: Icon(Icons.person), label: 'Profile')
//           ],
//         ),

class SecondNavBar<BottomNavigationBar> {}
