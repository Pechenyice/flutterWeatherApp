import 'package:flutter/material.dart';

class WeatherAppSettings extends StatefulWidget {
  const WeatherAppSettings({Key? key}) : super(key: key);

  @override
  _WeatherAppSettingsState createState() => _WeatherAppSettingsState();
}

class _WeatherAppSettingsState extends State<WeatherAppSettings> {
  List<bool> tempSettings = [true, false];
  List<bool> windSettings = [true, false];
  List<bool> paSettings = [false, true];

  // setting for 2 toggles only
  Widget createSetting(name, valuesList, valuesNamesList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
        Container(
          height: 25.0,
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
          child: ToggleButtons(
            isSelected: valuesList,
            borderRadius: BorderRadius.circular(20.0),
            borderWidth: 0.0,
            color: Colors.black,
            selectedColor: Colors.white,
            fillColor: Colors.blue[900],
            onPressed: (int newIndex) {
              setState(() {
                for (int i = 0; i < valuesList.length; i++) {
                  i == newIndex ?
                  valuesList[i] = true :
                  valuesList[i] = false;
                }
              });
            },
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: Text(
                  valuesNamesList[0],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: Text(
                  valuesNamesList[1],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
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
          'Настройки',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Color(0xFFE2EBFF),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Единицы измерения',
                      style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE2EBFF),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 9,
                      offset: Offset(0, 9), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      createSetting('Температура', tempSettings, ['˚C', '˚F']),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: Colors.black.withOpacity(.15),
                      ),
                      createSetting('Сила ветра', windSettings, ['м/с', 'км/ч']),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: Colors.black.withOpacity(.15),
                      ),
                      createSetting('Давление', paSettings, ['мм.рт.ст.', 'гПа'])
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
