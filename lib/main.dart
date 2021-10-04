import 'dart:ui';
import 'weatherAppMain.dart'
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
        '/settings': (context) => WeatherAppSettings()
      },
    );
  }
}


