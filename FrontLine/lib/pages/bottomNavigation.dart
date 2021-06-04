import 'package:flutter/material.dart';
import 'package:web_app/pages/home.dart';
import 'package:web_app/pages/noticeboard.dart';
import 'package:web_app/pages/logOut.dart';
import 'package:web_app/pages/request_report.dart';
import 'package:web_app/pages/user_profile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;

  final _pageOptions = [Home(), NoticeBoard(), RequestReport()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_important,
              size: 30,
            ),
            label: 'Noticeboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.visibility,
              size: 30,
            ),
            label: 'Requests/Reports',
          ),
        ],
        selectedItemColor: Colors.blue,
        elevation: 5.0,
        unselectedItemColor: Colors.lightBlue[900],
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (mounted) {
            setState(() {
              selectedPage = index;
            });
          }
        },
      ),
    );
  }
}
