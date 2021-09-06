import 'package:find_stick/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // Returns first page
    return MaterialApp(
      // Changes background color for all screens
      theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey[200]),
      home: Authentication(),
      debugShowCheckedModeBanner: false,
    );
  }
}
