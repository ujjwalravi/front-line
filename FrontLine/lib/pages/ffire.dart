import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_app/pages/loading.dart';
import 'package:web_app/pages/wrapper.dart';

class FFire extends StatefulWidget {
  @override
  _FFireState createState() => _FFireState();
}

class _FFireState extends State<FFire> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterfire() async {
    try {
      await Firebase.initializeApp();
      print('In Process');
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterfire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print('Error');
    }
    if (!_initialized) {
      print('SUCCESS');
      return Loading();
    }
    return Wrapper();
  }
}
