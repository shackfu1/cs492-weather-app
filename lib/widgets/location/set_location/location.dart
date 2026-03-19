import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/location/set_location/location_buttons.dart';
import 'package:weatherapp/widgets/location/saved_locations/saved_locations.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final TextEditingController _locationController = TextEditingController();
  String _errorText = "";

  late LocationProvider _locationActions;

  @override
  void initState() {
    super.initState();
    _locationController.addListener(() {
      if (_locationController.text.isNotEmpty) {
        setState(() {
          _errorText = "";
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationActions = context.read<LocationProvider>();
  }

  void _setLocation() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _errorText = "Error: Must Type Location";
      });
    } else {
      Future<bool> result =
          _locationActions.setLocationFromString(_locationController.text);
      result.then((success) {
        if (!success) {
          setState(() {
            _errorText = "Error: Invalid Location";
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    debugPrint("error: $_errorText");

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Builder(builder: (context) {
        final mq = MediaQuery.of(context);
        final effectiveHeight = mq.size.height - mq.viewInsets.bottom;
        final isLandscape = mq.size.width > effectiveHeight;
        final inputColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "Enter Location",
                errorText: _errorText.isEmpty ? null : _errorText,
              ),
            ),
            const SizedBox(height: 12),
            LocationButtons(
              setLocation: _setLocation,
              setLocationFromGps: _locationActions.setLocationFromGps,
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                locationProvider.location != null
                    ? "${locationProvider.location?.city}, ${locationProvider.location?.state} ${locationProvider.location?.zip}"
                    : "No Location...",
              ),
            ),
          ],
        );

        if (!isLandscape) {
          return SingleChildScrollView(
            child: Column(
              children: [
                inputColumn,
                const SizedBox(height: 12),
                SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: SavedLocations()),
              ],
            ),
          );
        } else {
          return Row(
            children: [
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: inputColumn,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                      height: double.infinity, child: SavedLocations()),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
