import 'package:flutter/material.dart';
import 'package:web_app/services/auth.dart';

class LogOut extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogOut'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0)),
          ),
          onPressed: () async {
            await _auth.logOut();
          },
          icon: Icon(Icons.logout),
          label: Text('LogOut'),
        ),
      ),
    );
  }
}
