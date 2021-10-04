import 'package:flutter/material.dart';

class WeatherAppMain extends StatefulWidget {
  const WeatherAppMain({Key? key}) : super(key: key);

  @override
  State<WeatherAppMain> createState() => _WeatherAppMainState();
}

class _WeatherAppMainState extends State<WeatherAppMain>
    with TickerProviderStateMixin {
  bool sheetIsActive = false;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;

    Widget WeatherPreview(time, imageUrl, data) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
        decoration: BoxDecoration(
          color: Color(0xFFE0E9FD),
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
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
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
                  letterSpacing: -1.0),
            ),
          ],
        ),
      );
    }

    Widget WeatherInfo(imageUrl, text) {
      return Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: Color(0xFFE2EBFF),
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
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              color: Color(0xFFE2EBFF),
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
                              '23 сентября',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17.0),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          WeatherPreview('06:00',
                              'assets/imgs/weatherPreview/rain.png', '10˚c'),
                          WeatherPreview(
                              '12:00',
                              'assets/imgs/weatherPreview/rain_small.png',
                              '10˚c'),
                          WeatherPreview('18:00',
                              'assets/imgs/weatherPreview/sun.png', '10˚c'),
                          WeatherPreview('00:00',
                              'assets/imgs/weatherPreview/spark.png', '10˚c'),
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
                              onPressed: () {},
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
                                    'assets/imgs/weatherInfo/temp.png', '8˚c'),
                                Divider(
                                  height: 8.0,
                                  thickness: 0.0,
                                  color: Colors.transparent,
                                ),
                                WeatherInfo(
                                    'assets/imgs/weatherInfo/breeze.png',
                                    '9м/с'),
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
                                    'assets/imgs/weatherInfo/water.png', '87%'),
                                Divider(
                                  height: 8.0,
                                  thickness: 0.0,
                                  color: Colors.transparent,
                                ),
                                WeatherInfo('assets/imgs/weatherInfo/pa.png',
                                    '761 мм.рт.ст'),
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
                          fontSize: 23.0, fontWeight: FontWeight.w800)),
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/background_light.png"),
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
                          child: Text("10˚c",
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
                      child: Text("23 сент. 2021",
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
                        elevation: 1.0,
                        fillColor: Colors.blue[800],
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
                          "Санкт-Петербург",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 1.0,
                        fillColor: Colors.blue[800],
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