import 'package:form_field_validator/form_field_validator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/screens/Info.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey<FormState> _key = GlobalKey();
  Map weatherData = {};
  String city = '';

  _valid() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      //to get the required info on next screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Info(
                    city: city,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/search.png',
                      height: 300.0, width: 300.0),
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: ListTile(
                    title: Form(
                      key: _key,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Enter City Name',
                        ),
                        validator: RequiredValidator(errorText: 'Required'),
                        onSaved: (value) => city = value!,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: new RawMaterialButton(
                    shape: new CircleBorder(),
                    elevation: 0.0,
                    child: FaIcon(
                      FontAwesomeIcons.searchLocation,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {
                      _valid();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
