import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherAppAddPreference extends StatefulWidget {
  const WeatherAppAddPreference({Key? key}) : super(key: key);

  @override
  _WeatherAppAddPreferenceState createState() =>
      _WeatherAppAddPreferenceState();
}

class _WeatherAppAddPreferenceState extends State<WeatherAppAddPreference> {
  List<String> constCities = ['Санкт-Петербург', 'Москва'];
  List<String> cities = ['Санкт-Петербург', 'Москва'];
  Set<String> savedCities = Set<String>();

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getStringList('cities'));
      savedCities =
          (prefs.getStringList('cities') ?? ['Санкт-Петербург']).toSet();
    });
    if (prefs.getStringList('cities') == null) {
      prefs.setStringList('cities', savedCities.toList());
    }
    // await prefs.setInt('counter', counter);
  }

  var _controller = TextEditingController();

  void _latestValue() {
    setState(() {
      cities = constCities.toList().where((c) => c.startsWith(_controller.text)).toList();
    });
  }

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    initPrefs();
    _controller.addListener(_latestValue);
  }

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
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: cities.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
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
                        onTap: () async {
                          setState(() {
                            isSaved
                                ? savedCities.remove(word)
                                : savedCities.add(word);
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setStringList("cities", savedCities.toList());
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
