import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:worldtime/worldtime.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationProvider>().location;
    final worldtimePlugin = Worldtime();
    final String myFormatter = '\\h:\\m';

    if (location == null) {
      return const SizedBox(height: 0);
    }

    Future<DateTime> getTime() async {
      return await worldtimePlugin.timeByLocation(
        latitude: location.latitude,
        longitude: location.longitude,
      );
    }

    return FutureBuilder<DateTime>(
      future: getTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 70,
            width: double.infinity,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return SizedBox(
            height: 70,
            width: double.infinity,
            child: Center(
              child: Text(
                'Could not load time',
                style: Theme.of(context)
                  .textTheme
                  .titleLarge
              ),
            ),
          );
        }

        final DateTime dateTime = snapshot.data!;
        final String timeString = worldtimePlugin.format(
          dateTime: dateTime,
          formatter: myFormatter,
        );

        return ExcludeSemantics(
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: Center(
              child: Text(
                timeString,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 70,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
