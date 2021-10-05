import 'package:flutter/material.dart';

class WeatherAppPreferences extends StatefulWidget {
  @override
  _WeatherAppPreferencesState createState() => _WeatherAppPreferencesState();
}

class _WeatherAppPreferencesState extends State<WeatherAppPreferences> {
  @override
  Widget build(BuildContext context) {

    List cities = ['Москва', 'Санкт-Петербург'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE2EBFF),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        title: Text(
          'Избранные',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: cities.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          String word = cities[index];

          return ListTile(
            title: Text(word),
            trailing: Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
            onTap: () {
              setState(() {
                cities.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
