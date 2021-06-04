import 'package:flutter/material.dart';
import 'package:web_app/services/database.dart';
import 'package:web_app/services/datetime.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final Date d = Date();
  final DatabaseService db = DatabaseService();
  var _controller = TextEditingController();
  String _date = 'Finding...';
  int _totalEmployee = 0;
  int _presentEmployee = 0;
  String _lastNotice = 'Last Posted notice is shhown here';
  String _lastDBNotice = '';
  String _usernametoSearch = 'noOne';

  void getthetodayDate() async {
    String temp = await d.getTodayDate();
    if (mounted) {
      setState(() {
        _date = temp;
      });
    }
  }

  void getTotalValues() async {
    List _totalTemp = await db.getTotal();
    setState(() {
      _totalEmployee = _totalTemp.length;
    });
  }

  void getTodayValues() async {
    List _todayTemp = await db.getToday(_date);
    setState(() {
      _presentEmployee = _todayTemp.length;
    });
  }

  void getlastNotice() async {
    Map _noticeTemp = await db.getNotice();
    setState(() {
      _lastDBNotice = _noticeTemp['notice'];
    });
  }

  @override
  void initState() {
    super.initState();
    getthetodayDate();
    getTotalValues();
    getTodayValues();
    getlastNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello, admin'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 5.0),
                Center(
                  child: Text(
                    _date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.lightBlueAccent[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 30.0,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Refresh Dashboard',
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
                    getthetodayDate();
                    getTotalValues();
                    getTodayValues();
                    print('after await');
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        child: SafeArea(
                          child: Column(
                            children: [
                              Text(
                                '$_totalEmployee',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text('Total Employee'),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        //print('1');
                        Navigator.of(context)
                            .pushNamed('/user_list', arguments: {
                          'd': _date,
                          'value': await db.getTotal(),
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '$_presentEmployee',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text('Present Employee'),
                          ],
                        ),
                      ),
                      onTap: () async {
                        print('2');
                        Navigator.of(context)
                            .pushNamed('/user_list', arguments: {
                          'd': _date,
                          'value': await db.getToday(_date),
                        });
                      },
                    ),
                    GestureDetector(
                      child: SafeArea(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                '${_totalEmployee - _presentEmployee}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text('Absent Employee'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightBlueAccent[100],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 30.0,
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              'View Requests and Reports',
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
                      Navigator.pushNamed(context, '/request_report');
                    }),
                SizedBox(height: 15.0),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'NOTICEBOARD',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.0),
                        TextField(
                          minLines: 3,
                          maxLines: 10,
                          maxLength: 250,
                          //controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'type notice here...',
                            border: OutlineInputBorder(),
                            focusColor: Colors.greenAccent[200],
                          ),
                          onChanged: (val) {
                            if ((val == null) | (val == '')) {
                              print('null entered');
                            } else {
                              setState(() {
                                _lastNotice = val;
                              });
                            }
                          },
                        ),
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    await db.updateNoticeboardCollectionData(
                                        _lastNotice);
                                    getlastNotice();
                                  },
                                  icon: Icon(Icons.send),
                                  label: Text('POST NOTICE'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 2.0),
                        GestureDetector(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.lightBlueAccent[100],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.notifications,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      'View the Noticeboard',
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
                              Navigator.pushNamed(context, '/notice');
                            }),
                        SizedBox(height: 5.0),
                        Container(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Search for Employee',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.0),
                                TextField(
                                  controller: _controller,
                                  //minLines: 1,
                                  //maxLines: 2,
                                  //maxLength: 50,
                                  decoration: InputDecoration(
                                    hintText: 'search for username...',
                                    border: OutlineInputBorder(),
                                    focusColor: Colors.blueAccent[200],
                                  ),
                                  onChanged: (val) {
                                    if ((val == null) | (val == '')) {
                                      print('null entered');
                                    } else {
                                      setState(() {
                                        _usernametoSearch = val;
                                      });
                                    }
                                  },
                                ),
                                ElevatedButton.icon(
                                  icon: Icon(Icons.search),
                                  label: Text('SEARCH FOR PROFILE'),
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .pushNamed('/user_profile', arguments: {
                                      'value': await db
                                          .getUserProfile(_usernametoSearch),
                                    });
                                  },
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
