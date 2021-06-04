import 'package:flutter/material.dart';
import 'package:web_app/services/database.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  String _latestNotice = 'No new Notices';
  final DatabaseService db = DatabaseService();

  void getlastNotice() async {
    Map _noticeTemp = await db.getNotice();
    setState(() {
      _latestNotice = _noticeTemp['notice'];
    });
  }

  @override
  void initState() {
    super.initState();
    getlastNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('noticeboard'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 5.0),
              Center(
                child: Text(
                  'Recent notice here',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              //Text(_latestNotice),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.lightBlueAccent[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 15.0),
                      Text(
                        '$_latestNotice',
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
            ],
          ),
        ),
      ),
    );
  }
}
