import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_app/services/auth.dart';
import 'package:web_app/services/covid.dart';
import 'package:web_app/services/quotes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_app/pages/mark_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_app/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PositiveQuotes q = PositiveQuotes();
  CovidData c = CovidData();
  final DatabaseService db = DatabaseService();
  final AuthenticationService _auth = AuthenticationService();
  var _controller = TextEditingController();
  String _quotess = "Loading...";
  String _author = "Loading...";
  String _requests;
  //String _initval = '';
  int _totalCases = 0, _totalRecovered = 0, _totalDeath = 0;

  void gettheQuotes() async {
    Map temp = await q.getQuotes();
    if (mounted) {
      setState(() {
        _quotess = temp['q'];
        _author = temp['a'];
      });
    }
  }

  void getthecoviddata() async {
    Map covidTemp = await c.getCovidData();
    if (mounted) {
      setState(() {
        _totalCases = covidTemp["total"];
        _totalRecovered = covidTemp["discharged"];
        _totalDeath = covidTemp["deaths"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gettheQuotes();
    getthecoviddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dashboard'),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blueAccent[400],
        leading: ModalWidget(),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'profile settings',
            onPressed: () async {
              Navigator.of(context)
                  .pushNamed('/user_profile_settings', arguments: {
                'value': await db.getUserProfile(
                    FirebaseAuth.instance.currentUser.displayName),
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'logout',
            onPressed: () async {
              await _auth.logOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // Quote
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //SizedBox(height: 1.0),
            Center(
              child: ListTile(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Quote of the day! by     -- $_author',
                      textAlign: TextAlign.center,
                    ),
                  ));
                },
                tileColor: Colors.yellowAccent[100],
                title: Text(
                  _quotess,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.padauk(
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 10.0),
            SizedBox(height: 5.0),
            Row(
              // Covid Data
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  //color: Colors.redAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${_totalCases - _totalRecovered}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.redAccent[700],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Active Cases',
                          style: TextStyle(
                            color: Colors.redAccent[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //color: Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "$_totalRecovered",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.green[700],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Total Recovered',
                          style: TextStyle(
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "$_totalDeath",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Total Deceased',
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.lightBlueAccent[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 30.0,
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        'Mark your Attendance',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarkAttendance()),
                );
                print('after await');
              },
            ),
            // Attendance Button
            SizedBox(height: 25.0),
            Center(
              child: Text(
                'Request or Report something',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 2.0),
              child: TextField(
                minLines: 3,
                maxLines: 10,
                controller: _controller,
                //maxLength: 250,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  focusColor: Colors.greenAccent[200],
                ),
                onChanged: (val) {
                  if ((val == null) | (val == '')) {
                    print('null entered');
                  } else {
                    setState(() {
                      _requests = val;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        await DatabaseService(
                                uid:
                                    '${FirebaseAuth.instance.currentUser.displayName}')
                            .updateRequestCollectionData(_requests);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send),
                      label: Text('POST REQUESTS OR REPORT'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.lightBlueAccent[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 30.0,
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        'View my profile',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                Navigator.of(context).pushNamed('/user_profile', arguments: {
                  'value': await db.getUserProfile(
                      FirebaseAuth.instance.currentUser.displayName),
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// For Modals

class ModalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_outline),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Colors.yellowAccent[100],
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'App developed for e-Yantra by: ',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'RAVI UJJWAL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'ABHINAV UMRAO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'RAHUL RATNAM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
