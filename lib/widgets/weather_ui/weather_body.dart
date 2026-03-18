import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/widgets/forecast/forecast.dart';
import 'package:weatherapp/widgets/location/set_location/location.dart';
import 'package:weatherapp/providers/theme_provider.dart';


class WeatherAppBody extends StatelessWidget {
  const WeatherAppBody({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          ForecastWidget(),
          LocationWidget(),
        ],
      ),
      floatingActionButton:  Semantics(
        label: "Dark Mode Switch",
        child: Switch(
            value: themeProvider.darkMode,
            onChanged: (value) => {themeProvider.setDarkMode(value)}),
      ),
    );
  }
}