import 'package:flutter/material.dart';
import 'package:web_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileSettings extends StatefulWidget {
  @override
  _UserProfileSettingsState createState() => _UserProfileSettingsState();
}

class _UserProfileSettingsState extends State<UserProfileSettings> {
  //final _formKey = GlobalKey<FormState>();
  String newfName = '';
  String newDName = '';
  String newEName = '';
  @override
  Widget build(BuildContext context) {
    final routesData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Map _temp = routesData['value'];
    //print(_temp);
    String username = FirebaseAuth.instance.currentUser.displayName;
    String _initfName = _temp['fName'];
    String _initDesignation = _temp['designation'];
    String _initExperience = _temp['experience'];

    return Scaffold(
      appBar: AppBar(
        title: Text('@$username\'s profile settings'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            //key: _formKey,
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
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Full Name'),
                    initialValue: _initfName,
                    validator: (value) =>
                        value.isEmpty ? 'Enter proper Full Name' : null,
                    onChanged: (value) {
                      setState(() {
                        _initfName = value;
                        newfName = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Designation'),
                    initialValue: _initDesignation,
                    validator: (value) =>
                        value.isEmpty ? 'Enter proper Designation' : null,
                    onChanged: (value) {
                      setState(() {
                        _initDesignation = value;
                        newDName = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Experience'),
                    initialValue: _initExperience,
                    validator: (value) =>
                        value.isEmpty ? 'Enter proper Experience' : null,
                    onChanged: (value) {
                      setState(() {
                        _initExperience = value;
                        newEName = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton.icon(
                  icon: Icon(Icons.upload_rounded),
                  label: Text('UPDATE PROFILE'),
                  onPressed: () async {
                    //print(username);
                    await DatabaseService(uid: username)
                        .updateUserProfileCollectionData(
                            username, newfName, newDName, newEName);

                    //setState(() {
                    //_initfName = _initfName;
                    //_initExperience = _initExperience;
                    //_initDesignation = _initDesignation;
                    // });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
