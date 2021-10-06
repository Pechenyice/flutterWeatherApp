import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherAppLoading extends StatefulWidget {
  const WeatherAppLoading({Key? key}) : super(key: key);

  @override
  _WeatherAppLoadingState createState() => _WeatherAppLoadingState();
}

class _WeatherAppLoadingState extends State<WeatherAppLoading> {

  List weather = [];
  String currentCity = 'Санкт-Петербург';

  Future<void> getWeather() async {
    Response response = await get(Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$currentCity&cnt=6&appid=f6bd006ca2e0d7841a2d086ff08db0fe'));
    Map data = jsonDecode(response.body);
    weather = data['list'];
    Navigator.pushReplacementNamed(context, '/', arguments: {
      'weather': weather
    });
  }

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentCity = prefs.getString('activeCity') ?? 'Санкт-Петербург';
  }

  void init() async {
    await initPrefs();
    await getWeather();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE2EBFF)
        ),
        child: Column(
          children: [
            SizedBox(height: 120.0,),
            Center(
              child: Text(
                "Weather",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            SizedBox(height: 120.0,),
            Text("svg loader: null pointer")
          ],
        ),
      ),
    );
  }
}
