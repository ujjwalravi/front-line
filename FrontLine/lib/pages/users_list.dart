import 'package:flutter/material.dart';
import 'package:web_app/services/database.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  //final List<String> entries = <String>['A', 'B', 'C'];
  //final List<int> colorCodes = <int>[600, 500, 100];
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final routesData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    //print(routesData['d']);
    final List _temp = routesData['value'];
    //print(_temp);
    return Scaffold(
      appBar: AppBar(
        title: Text('users list'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: _temp.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.lightBlueAccent[200],
                child: Center(child: Text('@ ${_temp[index]['username']}')),
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
