import 'package:find_stick/screens/auth_screen.dart';
import 'package:find_stick/screens/create_account.dart';
import 'package:find_stick/widgets/bottom_bar.dart';
import 'package:find_stick/widgets/list_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';

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
  var mainBackgroundColor = HexColor('3A3A3A');
  // var elevatedButtonColor = HexColor('93B5C3');
  var elevatedButtonColor = Colors.black45;
  var iconColor = HexColor('E07619');
  @override
  Widget build(BuildContext context) {
    // Returns first page
    return MaterialApp(
      // home: CarList(),
      home: Authentication(),
      initialRoute: '/',
      routes: {
        '/home': (context) => CarList(),
        '/login': (context) => Authentication(),
        '/createAccount': (context) => CreateAccount(),
      },
      debugShowCheckedModeBanner: false,
      // Changes background color for all screens
      theme: ThemeData(
        dialogTheme: DialogTheme(
          backgroundColor: HexColor('2B3240'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        dividerColor: mainBackgroundColor,
        iconTheme: IconThemeData(color: iconColor),
        textTheme: TextTheme(
          // * changes color of price on list_view
          caption: TextStyle(color: Colors.white),
          // * changes color of year and mileage on list_view
          subtitle1: TextStyle(color: Colors.white),
        ),
        // * Changes colors and shape of all elevated buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontSize: 15,
                color: Colors.orange,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              elevatedButtonColor,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: HexColor('EE6C4D'),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: iconColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: HexColor('ffffff'),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        scaffoldBackgroundColor: mainBackgroundColor,

        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: HexColor('C9C9C9'),
            fontSize: 15,
          ),
          fillColor: HexColor('EE6C4D'),
          filled: false,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('EE6C4D'),
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('EE6C4D'),
            ),
          ),
        ),
      ),
    );
  }
}
