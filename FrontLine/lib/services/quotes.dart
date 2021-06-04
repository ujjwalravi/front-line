import 'package:http/http.dart';
import 'dart:convert';

class PositiveQuotes {
  String quotes;

  Future<Map> getQuotes() async {
    var url = Uri.parse(
        'https://thingproxy.freeboard.io/fetch/http://zenquotes.io/api/random');
    var response = await get(url);
    //print(response);
    List data = jsonDecode(response.body);
    Map hashdata = data[0];
    //print(hashdata);
    //quotes = hashdata['q'];
    return hashdata;
  }
}
