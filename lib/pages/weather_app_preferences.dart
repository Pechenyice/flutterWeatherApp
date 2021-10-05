import 'package:flutter/material.dart';

class WeatherAppPreferences extends StatefulWidget {
  @override
  _WeatherAppPreferencesState createState() => _WeatherAppPreferencesState();
}

class _WeatherAppPreferencesState extends State<WeatherAppPreferences> {
  List cities = ['Москва', 'Санкт-Петербург'];

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFE2EBFF)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: ListView.separated(
            itemCount: cities.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              String word = cities[index];

              return Container(
                decoration: BoxDecoration(
                    color: Color(0xFFDEE9FF),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: -6.0,
                        blurRadius: 12.0,
                      ),
                    ]),
                child: ListTile(
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
