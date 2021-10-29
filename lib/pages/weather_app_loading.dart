import 'dart:convert';
import 'dart:developer';
import 'package:flutter_weather_app/helpers/ThemeColors.dart';
import 'package:flutter_weather_app/helpers/ThemeImages.dart';
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
  bool darkTheme = false;

  Future<void> getWeather(Client client) async {
    Response response = await client.get(Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$currentCity&cnt=6&appid=f6bd006ca2e0d7841a2d086ff08db0fe'));
    Map data = jsonDecode(response.body);
    setState(() {
      weather = data['list'];
    });
  }

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentCity = prefs.getString('activeCity') ?? 'Санкт-Петербург';
    darkTheme = prefs.getStringList('themeSettings')?.elementAt(1) == "1";
    if (darkTheme) {
        ThemeColors.black = Colors.white;
        ThemeColors.white = Colors.black;
        ThemeColors.weatherBackground = Color(0xFF0C172B);
        ThemeColors.weatherPreview = Color(0xFF0D182C);
        ThemeColors.weekGradientStart = Color(0xFF223B70);
        ThemeColors.weekGradientEnd = Color(0xFF0F1F40);
        ThemeColors.menuButtons = Color(0xFF0A1743);
        ThemeImages.background = const AssetImage("assets/imgs/background_dark.png");
    }
  }

  void init() async {
    await initPrefs();
    await getWeather(Client());
    await Navigator.pushReplacementNamed(context, '/main', arguments: {
      'weather': weather
    });
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
          color: ThemeColors.weatherBackground
        ),
        child: Column(
          children: [
            SizedBox(height: 120.0,),
            Center(
              child: Text(
                "Weather",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors.black
                ),
              ),
            ),
            SizedBox(height: 120.0,),
            Text("svg loader: null pointer", style: TextStyle(color: ThemeColors.black),)
          ],
        ),
      ),
    );
  }
}
