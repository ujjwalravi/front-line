import 'package:http/http.dart';
import 'dart:convert';

class Date {
  String date;

  Future<String> getTodayDate() async {
    var url = Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Kolkata/');

    var response = await get(url);
    Map data = jsonDecode(response.body);
    String datestring = data['datetime'];
    date = datestring.substring(0, 10); //YYYY-MM-DD
    return date;
  }
}
