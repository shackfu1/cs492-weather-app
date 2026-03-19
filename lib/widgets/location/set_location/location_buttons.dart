import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/location/set_location/location_button.dart';

class LocationButtons extends StatelessWidget {
  const LocationButtons(
      {super.key,
      required this.setLocation,
      required this.setLocationFromGps});

  final void Function() setLocation;
  final void Function() setLocationFromGps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LocationButton(
            callbackFunction: setLocation, description: "Set Location"),
        LocationButton(
            callbackFunction: setLocationFromGps, description: "GPS"),
      ],
    );
  }
}