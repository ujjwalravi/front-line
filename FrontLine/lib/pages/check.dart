import 'package:flutter/material.dart';
import 'package:web_app/pages/sign_in.dart';
import 'package:web_app/services/auth.dart';

class Check extends StatefulWidget {
  final Function changeView;
  Check({this.changeView});
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Password should be minimum 6 characters'
                            : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.regEmailPwd(email, password);
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
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}


// Register

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (value) => value.isEmpty
                            ? 'Password should be minimum 6 characters'
                            : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.regEmailPwd(email, password);
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
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));


    // sign in

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: 300,
                child: Image(
                  image: AssetImage("images/Login.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'E-mail',
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
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _auth.signInEmailPwd(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Could not sign in';
                              });
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Text('Create an Account?'),
                onTap: () {
                  widget.changeView();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
