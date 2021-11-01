import 'package:find_stick/screens/auth_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        home: Authentication(),
        debugShowCheckedModeBanner: false,
        // Changes background color for all screens
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.black45, elevation: 0),
          scaffoldBackgroundColor: Colors.blueGrey,
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.blue,
              filled: false,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              hintStyle: TextStyle(color: Colors.white.withAlpha(80))),
        ));
  }
}
