import 'package:flutter/material.dart';
import 'package:flutter_weather_app/helpers/ThemeColors.dart';
import 'package:flutter_weather_app/helpers/ThemeImages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeatherAppMain extends StatefulWidget {
  const WeatherAppMain({Key? key}) : super(key: key);

  @override
  State<WeatherAppMain> createState() => _WeatherAppMainState();
}

class _WeatherAppMainState extends State<WeatherAppMain>
    with TickerProviderStateMixin {
  bool sheetIsActive = false;

  Map args = {};

  String currentCity = 'Санкт-Петербург';

  bool isC = true;
  bool isMpS = true;
  bool isMm = true;

  late DateFormat dateFormat;

  late final AnimationController _controller;

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempS = prefs.getStringList('tempSettings') ?? ["1", "0"];
    List<String> windS = prefs.getStringList('windSettings') ?? ["1", "0"];
    List<String> paS = prefs.getStringList('paSettings') ?? ["1", "0"];
    setState(() {
      isC = tempS[0] == '1' ? true : false;
      isMpS = windS[0] == '1' ? true : false;
      isMm = paS[0] == '1' ? true : false;
      currentCity = prefs.getString('activeCity') ?? 'Санкт-Петербург';
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    initPrefs();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('ru');
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
    try {
      args = ModalRoute
          .of(context)!
          .settings
          .arguments as Map;
    } catch(e) {

    }
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    var dateTime = new DateTime.now();

    Widget WeatherPreview(time, imageUrl, data) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
        decoration: BoxDecoration(
          color: ThemeColors.weatherPreview,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 9,
              offset: Offset(0, 9), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color: ThemeColors.black),
            ),
            Divider(
              height: 10.0,
            ),
            Image.asset(
              imageUrl,
              width: 40.0,
            ),
            Divider(
              height: 10.0,
            ),
            Text(
              data,
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.0, color: ThemeColors.black),
            ),
          ],
        ),
      );
    }

    Widget WeatherInfo(imageUrl, text) {
      return Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: ThemeColors.weatherBackground,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 9,
              offset: Offset(0, 9), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
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
                  color: ThemeColors.black
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget bottomArea = NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification DSNotification) {
        if (DSNotification.extent >= 0.5) {
          setState(() {
            sheetIsActive = true;
            _controller.forward();
          });
        } else if (DSNotification.extent < 0.5) {
          setState(() {
            sheetIsActive = false;
            _controller.reverse();
          });
        } else {
          setState(() {
            sheetIsActive = sheetIsActive;
          });
        }
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
            child: Container(
              color: ThemeColors.weatherBackground,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 50.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 60.0,
                          height: 6.0,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)))),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0,
                            16.0 + (sheetIsActive ? 16.0 : 0.0), 0.0, 32.0),
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: sheetIsActive ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              dateFormat.format(dateTime),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17.0, color: ThemeColors.black),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          WeatherPreview('06:00',
                              getWeatherIconPath(args['weather'][2]['weather'][0]['main']), '${(isC ? (args['weather'][2]['main']['temp'] - 273) : (args['weather'][2]['main']['temp'] - 273)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                          WeatherPreview(
                              '12:00',
                              getWeatherIconPath(args['weather'][3]['weather'][0]['main']),
                              '${(isC ? (args['weather'][3]['main']['temp'] - 273) : (args['weather'][3]['main']['temp'] - 273)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                          WeatherPreview('18:00',
                              getWeatherIconPath(args['weather'][4]['weather'][0]['main']), '${(isC ? (args['weather'][4]['main']['temp'] - 273) : (args['weather'][4]['main']['temp'] - 273)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                          WeatherPreview('00:00',
                              getWeatherIconPath(args['weather'][5]['weather'][0]['main']), '${(isC ? (args['weather'][5]['main']['temp'] - 273) : (args['weather'][5]['main']['temp'] - 273)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                        ],
                      ),
                      Divider(
                        height: 16.0,
                        thickness: 0.0,
                        color: Colors.transparent,
                      ),
                      if (!sheetIsActive)
                        Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/week', arguments: {
                                  'temp': (args['weather'][0]['main']['temp'] - 273).toStringAsFixed(1),
                                  'pressure': args['weather'][0]['main']['pressure'],
                                  'humidity': args['weather'][0]['main']['humidity'],
                                  'wind': (args['weather'][0]['wind']['speed']).toStringAsFixed(1),
                                  'icon': args['weather'][0]['weather'][0]['main'],
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return ThemeColors.white;
                                      }
                                      return ThemeColors.white;
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
                              child: const Text("Прогноз на неделю"),
                            )),
                      Divider(
                        height: 16.0,
                        thickness: 0.0,
                        color: Colors.transparent,
                      ),
                      if (sheetIsActive)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                WeatherInfo(
                                    'assets/imgs/weatherInfo/temp.png', '${(isC ? (args['weather'][1]['main']['temp'] - 273) : (args['weather'][1]['main']['temp'] - 273)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                                Divider(
                                  height: 8.0,
                                  thickness: 0.0,
                                  color: Colors.transparent,
                                ),
                                WeatherInfo(
                                    'assets/imgs/weatherInfo/breeze.png',
                                    '${(isMpS ? (args['weather'][1]['wind']['speed']) : (args['weather'][1]['wind']['speed']) * 3.6).toStringAsFixed(1)}${isMpS ? 'м/с' : 'км/ч'}'),
                              ],
                            ),
                            // VerticalDivider(
                            //   width: 20.0,
                            //   thickness: 0,
                            //   color: Colors.transparent,
                            // ),
                            Column(
                              children: <Widget>[
                                WeatherInfo(
                                    'assets/imgs/weatherInfo/water.png', '${(args['weather'][1]['main']['humidity'])}%'),
                                Divider(
                                  height: 8.0,
                                  thickness: 0.0,
                                  color: Colors.transparent,
                                ),
                                WeatherInfo('assets/imgs/weatherInfo/pa.png',
                                    '${(args['weather'][1]['main']['pressure'])} ${isMm ? 'мм.рт.ст' : 'кПа'}'),
                              ],
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.weatherBackground
          ),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 32.0, 0.0, 0.0),
                child: Column(
                  children: [
                    Text("Weather app",
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.w800, color: ThemeColors.black)),
                    InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/imgs/menuIcons/settings.png'),
                                VerticalDivider(
                                  width: 14.0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'Настройки',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                      color: ThemeColors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/imgs/menuIcons/like.png'),
                                VerticalDivider(
                                  width: 14.0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'Избранные',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                      color: ThemeColors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/preferences');
                      },
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/imgs/menuIcons/about.png'),
                                VerticalDivider(
                                  width: 14.0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'О приложении',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                      color: ThemeColors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/about');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ThemeImages.background,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0.0, 0.0 + (50.0 * _controller.value)),
                          child: Text("${(isC ? (args['weather'][1]['main']['temp'] - 273) : (args['weather'][1]['main']['temp'] - 273)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -10.0,
                                  height: 1.15)),
                        );
                      },
                    ),
                    AnimatedOpacity(
                      opacity: !sheetIsActive ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(dateFormat.format(dateTime),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            bottomArea,
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        elevation: 4.0,
                        fillColor: ThemeColors.menuButtons,
                        child: Icon(
                          Icons.menu,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(7.5),
                        shape: CircleBorder(),
                      ),
                      AnimatedOpacity(
                        opacity: sheetIsActive ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          currentCity,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addPreference');
                        },
                        elevation: 4.0,
                        fillColor: ThemeColors.menuButtons,
                        child: Icon(
                          Icons.add,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(7.5),
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}