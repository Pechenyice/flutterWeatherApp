import 'dart:ui';
import 'package:flutter_weather_app/pages/weather_app_about.dart';
import 'pages/weather_app_loading.dart';
import 'pages/weather_app_main.dart';
import 'pages/weather_app_week.dart';
import 'pages/weather_app_add_preference.dart';
import 'pages/weather_app_settings.dart';
import 'pages/weather_app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Manrope'),
      initialRoute: '/',
      routes: {
        '/': (context) => WeatherAppMain(),
        '/loading': (context) => WeatherAppLoading(),
        '/settings': (context) => WeatherAppSettings(),
        '/preferences': (context) => WeatherAppPreferences(),
        '/about': (context) => WeatherAppAbout(),
        '/week': (context) => WeatherAppWeek(),
        '/addPreference': (context) => WeatherAppAddPreference()
      },
    );
  }
}


