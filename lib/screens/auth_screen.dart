import 'package:find_stick/screens/create_account.dart';
import 'package:find_stick/screens/home_screen.dart';
// import 'package:find_stick/screens/register_screen.dart';
import 'package:find_stick/services/auth.dart';
import 'package:find_stick/widgets/bottom_bar.dart';
import 'package:find_stick/widgets/list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _forgotEmailField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Find Stick',
            style: TextStyle(fontSize: 25, fontFamily: 'InputSans'),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(children: [
              // logo
              SizedBox(
                height: 200,
                width: 300,
                child: Container(
                  child: Image.asset(
                    'lib/images/R_2.png',
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  margin: EdgeInsets.only(top: 0.0),
                  child: TextFormField(
                    controller: _emailField,
                    decoration: InputDecoration(
                        hintText: 'something@email.com',
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white70)),
                  )),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 50,
                ),
                child: TextFormField(
                  controller: _passwordField,
                  // textAlign: TextAlign.center,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: '',
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white70)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: HexColor('C9C9C9')),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Enter Email'),
                              content: TextFormField(
                                controller: _forgotEmailField,
                                decoration: InputDecoration(
                                    prefixIconColor: Colors.black,
                                    hintText: 'something@gmail.com'),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Send'),
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _forgotEmailField.text);
                                  },
                                ),
                              ],
                            );
                          });
                    }),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_emailField.text.isNotEmpty &&
                        _passwordField.text.isNotEmpty) {
                      final bool isSuccess =
                          await signIn(_emailField.text, _passwordField.text);
                      if (isSuccess) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        print('error');
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              new Expanded(
                child: Divider(
                    // color: Colors.blueGrey,
                    ),
              ),
              new Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                    );
                  },
                  child: Text('Create Account'),
                ),
              ),
            ]),
          ),
        ));
  }
}
