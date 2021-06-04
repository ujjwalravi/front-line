import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_app/services/database.dart';

class RequestReport extends StatefulWidget {
  @override
  _RequestReportState createState() => _RequestReportState();
}

class _RequestReportState extends State<RequestReport> {
  final DatabaseService _db = DatabaseService();
  List _data = [
    {'request': 'Loading...'}
  ];

  void gettherequests() async {
    List _temp = await _db.getRequest();
    print('printing...');
    setState(() {
      _data = _temp;
      print(_data);
      print('${_data.length}');
    });
  }

  @override
  void initState() {
    super.initState();
    gettherequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('requests & reports'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: _data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent[100],
                ),
                //height: 90,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 35.0, horizontal: 10.0),
                  child: Text(
                    '${_data[index]['request']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
    );
  }
}
