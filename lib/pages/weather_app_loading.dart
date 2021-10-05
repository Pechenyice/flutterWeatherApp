import 'package:flutter/material.dart';

class WeatherAppLoading extends StatefulWidget {
  const WeatherAppLoading({Key? key}) : super(key: key);

  @override
  _WeatherAppLoadingState createState() => _WeatherAppLoadingState();
}

class _WeatherAppLoadingState extends State<WeatherAppLoading> {
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
