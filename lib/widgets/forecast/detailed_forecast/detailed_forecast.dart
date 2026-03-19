import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast/detailed_forecast_text.dart';

class DetailedForecast extends StatefulWidget {
  const DetailedForecast({super.key});

  @override
  State<DetailedForecast> createState() => _DetailedForecastState();
}

class _DetailedForecastState extends State<DetailedForecast> {

  @override
  Widget build(BuildContext context) {
    final activeForecast = context.watch<ForecastProvider>().activeForecast;
    final themeProvider = context.read<ThemeProvider>();

    if (activeForecast == null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Select a forecast to see details',
            style: TextStyle(color: themeProvider.grey),
          ),
        ),
      );
    }

    return ExcludeSemantics(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image(
                  image: AssetImage('assets/backgrounds/${activeForecast.imagePath}.png'),
                  fit: BoxFit.cover,
                ),
              ),
      
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              DetailedForecastText(activeForecast: activeForecast),
            ],
          ),
        ),
      ),
    );
  }
}
