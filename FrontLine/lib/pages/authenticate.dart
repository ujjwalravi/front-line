import 'package:flutter/material.dart';
import 'package:web_app/pages/register.dart';
import 'package:web_app/pages/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void changeView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(changeView: changeView);
    } else {
      return RegisterPage(changeView: changeView);
    }
  }
}
