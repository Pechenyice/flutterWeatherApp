import 'package:flutter/material.dart';
import 'package:flutter_weather_app/helpers/ThemeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherAppPreferences extends StatefulWidget {
  @override
  _WeatherAppPreferencesState createState() => _WeatherAppPreferencesState();
}

class _WeatherAppPreferencesState extends State<WeatherAppPreferences> {
  List<String> cities = ['Москва', 'Санкт-Петербург'];

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cities = prefs.getStringList('cities') ?? ['Санкт-Петербург'];
    });
    if (prefs.getStringList('cities') == null) {
      prefs.setStringList('cities', cities);
    }
    // await prefs.setInt('counter', counter);
  }

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.weatherBackground,
        iconTheme: IconThemeData(
          color: ThemeColors.black,
        ),
        elevation: 0.0,
        title: Text(
          'Избранные',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: ThemeColors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: ThemeColors.weatherBackground),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: ListView.separated(
            itemCount: cities.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              String word = cities[index];

              return Container(
                decoration: BoxDecoration(
                    color: ThemeColors.weatherBackground,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: -6.0,
                        blurRadius: 12.0,
                      ),
                    ]),
                child: ListTile(
                  title: Text(word, style: TextStyle(color: ThemeColors.black),),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: ThemeColors.black,
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      setState(() {
                        cities.removeAt(index);
                      });
                      prefs.setStringList('cities', cities);
                    },
                  ),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('activeCity', cities.elementAt(index));
                    Navigator.pushNamedAndRemoveUntil(context, '/loading', (route) => false);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
