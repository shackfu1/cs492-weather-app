import 'dart:convert';
import 'package:http/http.dart' as http;

class Forecast {
  int temperature;
  String windSpeed;
  String windDirection;
  String name;
  String shortForecast;
  String detailedForecast;
  bool isDaytime;
  String imagePath;

  Forecast(
      {required this.temperature,
      required this.windSpeed,
      required this.windDirection,
      required this.name,
      required this.shortForecast,
      required this.detailedForecast,
      required this.isDaytime,
      required this.imagePath});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
        temperature: json["temperature"],
        windSpeed: json['windSpeed'],
        windDirection: json["windDirection"],
        name: json["name"],
        shortForecast: json["shortForecast"],
        detailedForecast: json["detailedForecast"],
        isDaytime: json["isDaytime"],
        imagePath:
            getAssetFromDescription(json["shortForecast"], json["isDaytime"]));
  }
}

Future<List<Forecast>> getForecastsByLocation(double lat, double long) async {
  String forecastUrl = "https://api.weather.gov/points/$lat,$long";
  http.Response forecastResponse = await http.get(Uri.parse(forecastUrl));
  final Map<String, dynamic> forecastJson = jsonDecode(forecastResponse.body);

  http.Response forecastDetailResponse =
      await http.get(Uri.parse(forecastJson["properties"]["forecast"]));
  final Map<String, dynamic> forecastDetailJson =
      jsonDecode(forecastDetailResponse.body);

  List<Forecast> forecasts = [];

  List<dynamic> periods = forecastDetailJson["properties"]["periods"];

  for (int i = 0; i < periods.length; i++) {
    Map<String, dynamic> f = periods[i];
    forecasts.add(Forecast.fromJson(f));
  }

  return forecasts;
}

String getAssetFromDescription(String description, bool isDaytime){
  if (description.toLowerCase().contains("sunny") || description.toLowerCase().contains("clear")){
    if (isDaytime){
      return "clear_day";
    } else {
      return "clear_night";
    }
  }
  if (description.toLowerCase().contains("cloudy")) {
    if (isDaytime) {
      return "partly_cloudy_day";
    } else {
      return "partly_cloudy_night";
    }
  }
  if (description.toLowerCase().contains("snow")) {
    if (isDaytime) {
      return "cloudy_with_snow_light";
    } else {
      return "cloudy_with_snow_dark";
    }
  }
  if (description.toLowerCase().contains("thunder")){
    return "strong_thunderstorms";
  }
  if (description.toLowerCase().contains("rain") || description.toLowerCase().contains("drizzle") || description.toLowerCase().contains("showers")) {
    return "showers_rain";
  }
  if (description.toLowerCase().contains("dust") || description.toLowerCase().contains("haze") || description.toLowerCase().contains("smoke") || description.toLowerCase().contains("fog")) {
    return "haze_fog_dust_smoke";
  }
  if (description.toLowerCase().contains("sleet") || description.toLowerCase().contains("hail")) {
    return "mixed_rain_hail_sleet";
  }

  return "tornado";
}