import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_app/services/database.dart';
import 'package:web_app/services/datetime.dart';
import 'package:web_app/models/attendanceModel.dart';

class MarkAttendance extends StatefulWidget {
  @override
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  final Date _date = Date();
  String todayDate;

  void getthetodayDate() async {
    String _temp = await _date.getTodayDate();
    if (mounted) {
      setState(() {
        todayDate = _temp;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getthetodayDate();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //print('printing user');
    //print(user);
    return StreamBuilder<AttendanceModel>(
      stream: DatabaseService(uid: user.uid).attendanceDoc,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AttendanceModel attendanceDoc = snapshot.data;
          print(attendanceDoc.username);
          String _name = attendanceDoc.username;
          String _date = attendanceDoc.date;
          bool _presentStatus = attendanceDoc.isPresent;
          String _note = '';
          if ((_date == todayDate) & (_presentStatus == false)) {
            _note = 'never';
          } else if ((_presentStatus == true)) {
            _note = '$_date';
          } else {
            print('Something else');
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Hello, $_name'),
              centerTitle: true,
            ),
            body: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Today\'s date is $todayDate',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if ((_date == todayDate) &
                              (_presentStatus == false)) {
                            await DatabaseService(uid: user.uid)
                                .updateAttendanceCollectionData(
                                    _name, todayDate, true);
                          } else if ((_date != todayDate)) {
                            await DatabaseService(uid: user.uid)
                                .updateAttendanceCollectionData(
                                    _name, todayDate, true);
                          } else {
                            //print('Already Set');
                          }
                        },
                        icon: Icon(Icons.check),
                        label: Text('Mark Your Attendance'),
                      ),
                      SizedBox(height: 15.0),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 20.0),
                          text: 'Last Attendance Status',
                          children: <TextSpan>[
                            TextSpan(
                                text: ' $_note ',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green[800])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Text('Else');
        }
      },
    );
  }
}
