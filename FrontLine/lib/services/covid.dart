import 'package:http/http.dart';
import 'dart:convert';

class CovidData {
  String totalCases;
  String totalDeceased;
  String totalRecovered;

  Future<Map> getCovidData() async {
    var url = Uri.parse(
        "https://thingproxy.freeboard.io/fetch/https://api.rootnet.in/covid19-in/stats/latest");
    var response = await get(url);
    Map data = jsonDecode(response.body);
    Map cData = data["data"]["summary"];
    //print(cData["total"]); // Total cases
    //print(cData["discharged"]); // Recovered
    //print(cData["deaths"]); //  Deaths
    return cData;
  }
}
