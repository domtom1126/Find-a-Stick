import 'package:find_stick/widgets/car_list.dart';
import 'package:find_stick/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car List'),
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
      ),
      body: CarList(),
      bottomNavigationBar: NavBar(),
    );
  }
}
