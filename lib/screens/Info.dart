import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Info extends StatefulWidget {
  final city;
  Info({
    Key? key,
    @required this.city,
  }) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  var weatherData;
  bool isLoading = true;

  Future getWeather(city) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=0258532f02b780dd5716c7485767f65d&units=metric'));

      var data = jsonDecode(response.body);

      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      print('the error is $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: SpinKitThreeBounce(
              color: Colors.blue,
              size: 40.0,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 350,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              weatherData['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              weatherData['main']['temp'].toString() +
                                  '\u00B0' +
                                  'C',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.soundcloud),
                    title: Text('Feel\'s like'),
                    trailing: Text(
                      weatherData['main']['feels_like'].toString() +
                          '\u00B0' +
                          'C',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.temperatureLow),
                    title: Text('Minimum Temperature'),
                    trailing: Text(
                      weatherData['main']['temp_min'].toString() +
                          '\u00B0' +
                          'C',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.temperatureHigh),
                    title: Text('Maximum Temperature'),
                    trailing: Text(
                      weatherData['main']['temp_max'].toString() +
                          '\u00B0' +
                          'C',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloudSun),
                    title: Text('Sky'),
                    trailing: Text(
                      weatherData['weather'][0]['main'].toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Description'),
                    trailing: Text(
                      weatherData['weather'][0]['description'].toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed'),
                    trailing: Text(
                      weatherData['wind']['speed'].toString() + 'm/s',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloudRain),
                    title: Text('Humidity'),
                    trailing: Text(
                      weatherData['main']['humidity'].toString() + '%',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.weight),
                    title: Text('Pressure'),
                    trailing: Text(
                      weatherData['main']['pressure'].toString() + 'hPa',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search',
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
