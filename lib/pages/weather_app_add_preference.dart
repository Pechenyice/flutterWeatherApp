import 'package:flutter/material.dart';

class WeatherAppAddPreference extends StatefulWidget {
  const WeatherAppAddPreference({Key? key}) : super(key: key);

  @override
  _WeatherAppAddPreferenceState createState() => _WeatherAppAddPreferenceState();
}

class _WeatherAppAddPreferenceState extends State<WeatherAppAddPreference> {
  List cities = ['Санкт-петербург', 'Москва'];
  Set<String> savedCities = Set<String>();

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE2EBFF),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        title: Text(
          'Добавить в избранные',
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
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Введите город...',
                  suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Expanded(
                child: ListView.separated(
                  itemCount: cities.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    String word = cities[index];
                    bool isSaved = savedCities.contains(word);

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
                          isSaved ? Icons.star : Icons.star_border,
                          color: Colors.black,
                        ),
                        onTap: () {
                          setState(() {
                            setState(() {
                              isSaved ? savedCities.remove(word) : savedCities.add(word);
                            });
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
