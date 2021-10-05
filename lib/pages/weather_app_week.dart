import 'package:flutter/material.dart';

class WeatherAppWeek extends StatefulWidget {
  const WeatherAppWeek({Key? key}) : super(key: key);

  @override
  _WeatherAppWeekState createState() => _WeatherAppWeekState();
}

class _WeatherAppWeekState extends State<WeatherAppWeek> {

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

  @override
  Widget build(BuildContext context) {
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
                              "23 сентября",
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
                                "assets/imgs/weatherPreview/rain.png",
                              width: 80.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 45.0,),
                        Row(
                          children: [
                            WeatherRow(
                                'assets/imgs/weatherInfo/temp.png', '8˚c'),
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
                                '9м/с'),
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
                                'assets/imgs/weatherInfo/water.png', '87%'),
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
                                '761 мм.рт.ст'),
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
