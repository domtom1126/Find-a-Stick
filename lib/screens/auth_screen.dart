import 'package:find_stick/screens/home_screen.dart';
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
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 75,
                child: TextFormField(
                  controller: _emailField,
                  decoration: InputDecoration(
                      hintText: 'something@email.com', labelText: 'Email'),
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
                  decoration:
                      InputDecoration(hintText: '', labelText: 'Password'),
                )),
            Container(
              child: MaterialButton(
                  onPressed: () async {
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
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CarList()));
                    }
                  },
                  color: Colors.orange[400],
                  textColor: Colors.white,
                  child: Text('Login')),
            ),
            // Button for anon sign in
          ],
        ),
      ),
    );
  }
}
