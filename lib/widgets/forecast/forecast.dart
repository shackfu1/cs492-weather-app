import 'package:flutter/material.dart';

import 'package:weatherapp/widgets/forecast/detailed_forecast/detailed_forecast.dart';
import 'package:weatherapp/widgets/forecast/forecast_tiles/forecasts_row.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast/time.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ForecastsRowWidget(),
        ),
        if (mq.size.height > mq.size.width) ...[
          DetailedForecast(),
          Time(),
        ],
      ],
    );
  }
}
