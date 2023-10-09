import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class TestCountries extends StatefulWidget {
  const TestCountries({Key? key}) : super(key: key);

  @override
  State<TestCountries> createState() => _TestCountriesState();
}

class _TestCountriesState extends State<TestCountries> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CSCPicker(
            onCountryChanged: (value) {
              setState(() {
                countryValue = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                stateValue = value;
              });
            },
            onCityChanged: (value) {
              setState(() {
                cityValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
