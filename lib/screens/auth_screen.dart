import 'package:find_stick/screens/home_screen.dart';
import 'package:find_stick/screens/register_screen.dart';
import 'package:find_stick/services/auth.dart';
import 'package:find_stick/widgets/car_list.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          elevation: 0.0,
          title: Text("Sign Up"),
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
                    'lib/images/R.png',
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
                  )),
              Container(
                child: MaterialButton(
                    onPressed: () async {
                      // if the text fields are empty
                      if (_emailField.text.isEmpty ||
                          _passwordField.text.isEmpty) {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Please fill in all fields'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                      bool shouldNavigate =
                          await register(_emailField.text, _passwordField.text);
                      if (shouldNavigate) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CarList()));
                      }
                    },
                    color: Colors.orange[400],
                    textColor: Colors.white,
                    child: Text('Register')),
              ),
              Container(
                child: MaterialButton(
                  onPressed: () async {
                    if (_emailField.text.isEmpty ||
                        _passwordField.text.isEmpty) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill in all fields'),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CarList()));
                      // MaterialPageRoute(builder: (context) => CarList()));
                    }
                  },
                  color: Colors.orange[400],
                  textColor: Colors.white,
                  child: Text('Login'),
                ),
              ),
              new Expanded(
                child: Divider(
                  color: Colors.blueGrey,
                ),
              ),
              new Container(
                child: MaterialButton(
                  onPressed: () {
                    // button to send forgot Password to firebase
                    // sendPasswordResetEmail(_emailField.text);
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
