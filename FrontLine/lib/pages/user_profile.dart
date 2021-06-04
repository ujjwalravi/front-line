import 'package:flutter/material.dart';
import 'package:web_app/services/database.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routesData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Map _temp = routesData['value'];
    print('printing temp');
    return Scaffold(
      appBar: AppBar(
        title: Text('@${_temp['username']}'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('C'),
                      radius: 40.0,
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Text(
                  'USERNAME',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '@${_temp['username']}',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text(
                  'FULL NAME',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '${_temp['fName']}',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text(
                  'DESIGNATION',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '${_temp['designation']}',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                SizedBox(height: 15.0),
                Text(
                  'EXPERIENCE',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '${_temp['experience']}',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
