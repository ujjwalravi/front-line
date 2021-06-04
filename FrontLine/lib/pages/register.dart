import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_app/services/auth.dart';

class RegisterPage extends StatefulWidget {
  final Function changeView;
  RegisterPage({this.changeView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String password = '';
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                child: Image(
                  image: AssetImage("images/Login.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter proper Username' : null,
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter proper Email' : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (value) => value.length < 6
                              ? 'Password length must be of 6 characters'
                              : null,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        child: Text('Already a member?'),
                        onTap: () {
                          widget.changeView();
                        },
                      ),
                      SizedBox(height: 7.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth.regEmailPwd(
                                email, password, username);
                            if (result == null) {
                              setState(() {
                                error = 'Check you email or password';
                              });
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
