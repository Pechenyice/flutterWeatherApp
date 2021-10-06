import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeatherAppWeek extends StatefulWidget {
  const WeatherAppWeek({Key? key}) : super(key: key);

  @override
  _WeatherAppWeekState createState() => _WeatherAppWeekState();
}

class _WeatherAppWeekState extends State<WeatherAppWeek> {
  bool isC = true;
  bool isMpS = true;
  bool isMm = true;

  late DateFormat dateFormat;

  Map args = {};

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempS = prefs.getStringList('tempSettings') ?? ["1", "0"];
    List<String> windS = prefs.getStringList('windSettings') ?? ["1", "0"];
    List<String> paS = prefs.getStringList('paSettings') ?? ["1", "0"];
    isC = tempS[0] == '1' ? true : false;
    isMpS = windS[0] == '1' ? true : false;
    isMm = paS[0] == '1' ? true : false;
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('ru');
  }

  Widget WeatherRow(imageUrl, text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 25.0, height: 25.0, child: Image.asset(imageUrl)),
        VerticalDivider(
          width: 14.0,
          thickness: 0,
          color: Colors.transparent,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }

  String getWeatherIconPath(weather) {
    String imgPath;
    switch (weather) {
      case 'Clouds': {
        imgPath = 'assets/imgs/weatherPreview/rain_small.png';
        break;
      }
      case 'Clear': {
        imgPath = 'assets/imgs/weatherPreview/sun.png';
        break;
      }
      case 'Rain': {
        imgPath = 'assets/imgs/weatherPreview/rain.png';
        break;
      }
      default: {
        imgPath = 'assets/imgs/weatherPreview/spark.png';
        break;
      }
    }
    return imgPath;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as Map;
    var dateTime = new DateTime.now();

    return Scaffold(
      body: Container(
        color: Color(0xFFE2EBFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Прогноз на неделю",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color(0xFFCDDAF5),
                          Color(0xFF9CBCFF),
                        ],
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                    dateFormat.format(dateTime),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0,),
                        Row(
                          children: [
                            Image.asset(
                              getWeatherIconPath(args['icon']),
                              width: 80.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 45.0,),
                        Row(
                          children: [
                            WeatherRow(
                                'assets/imgs/weatherInfo/temp.png', '${args['temp']}${isC ? '˚C' : '˚F'}'),
                          ],
                        ),
                        Divider(
                          height: 25.0,
                          thickness: 0.0,
                          color: Colors.transparent,
                        ),
                        Row(
                          children: [
                            WeatherRow(
                                'assets/imgs/weatherInfo/breeze.png',
                                '${args['wind']}${isMpS ? 'м/с' : 'км/ч'}'),
                          ],
                        ),
                        Divider(
                          height: 25.0,
                          thickness: 0.0,
                          color: Colors.transparent,
                        ),
                        Row(
                          children: [
                            WeatherRow(
                                'assets/imgs/weatherInfo/water.png', '${args['humidity']}%'),
                          ],
                        ),
                        Divider(
                          height: 25.0,
                          thickness: 0.0,
                          color: Colors.transparent,
                        ),
                        Row(
                          children: [
                            WeatherRow('assets/imgs/weatherInfo/pa.png',
                                '${args['pressure']} ${isMm ? 'мм.рт.ст' : 'Па'}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 40.0,),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.resolveWith<Color>(
                          (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white;
                        }
                        return Color(0xFFEAF0FF);
                      }),
                  overlayColor:
                  MaterialStateProperty.resolveWith<Color>(
                          (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white;
                        }
                        return Colors.transparent;
                      }),
                  side: MaterialStateProperty.resolveWith((states) {
                    Color _borderColor;
                    if (states.contains(MaterialState.pressed)) {
                      _borderColor = Colors.white;
                    }
                    _borderColor = Colors.blue;

                    return BorderSide(color: _borderColor, width: 1);
                  }),
                  shape: MaterialStateProperty.resolveWith<
                      OutlinedBorder>((_) {
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10));
                  }),
                ),
                child: const Text("Назад на главную"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
