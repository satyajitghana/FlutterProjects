import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double theTemp;
  final double maxTemp;
  final int locationId;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final String created;
  final DateTime lastUpdated;
  final String location;

  Weather(
      {this.condition,
      this.formattedCondition,
      this.minTemp,
      this.theTemp,
      this.maxTemp,
      this.locationId,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.created,
      this.lastUpdated,
      this.location})
      : super([
          // Pass all the properties to Equatable so we can equate two instances
          condition,
          formattedCondition,
          minTemp,
          theTemp,
          maxTemp,
          locationId,
          windSpeed,
          windDirection,
          airPressure,
          humidity,
          visibility,
          created,
          lastUpdated,
          location
        ]);

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
      condition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']),
      formattedCondition: consolidatedWeather['weather_state_name'],
      minTemp: consolidatedWeather['min_temp'] as double,
      theTemp: consolidatedWeather['the_temp'] as double,
      maxTemp: consolidatedWeather['max_temp'] as double,
      locationId: json['woeid'] as int,
      windSpeed: consolidatedWeather['wind_speed'] as double,
      windDirection: consolidatedWeather['wind_direction'] as double,
      airPressure: consolidatedWeather['air_pressure'] as double,
      humidity: consolidatedWeather['humidity'] as int,
      visibility: consolidatedWeather['visibility'] as double,
      created: consolidatedWeather['created'],
      lastUpdated: DateTime.now(),
      location: json['title'],
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }

    return state;
  }
}
