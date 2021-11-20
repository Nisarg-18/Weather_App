import 'package:flutter/material.dart';
// import 'package:weather_app/screens/Info.dart';
import 'package:weather_app/screens/SearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(fontFamily: 'Sen', primaryColor: Colors.deepPurpleAccent),
      home: SearchPage(),
      // initialRoute: '/weatherInfo',
      // routes: {
      //   '/': (context) => SearchPage(),
      // },
    );
  }
}
