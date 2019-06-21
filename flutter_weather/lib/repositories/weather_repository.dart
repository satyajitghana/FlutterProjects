// The WeatherRepository serves as an abstraction between the client code and the data provider
// so that as a developer working on features, you don't have to know where the data is coming from.
// Our WeatherRepository will have a dependency on our WeatherApiClient that we just created and it will expose
// a single public method called, you guessed it, getWeather(String city). No one needs to know that under the hood
// we need to make two API calls (one for locationId and one for weather) because no one really cares.
// All we care about is getting the Weather for a given city.

import 'dart:async';

import 'package:meta/meta.dart';

import 'package:flutter_weather/repositories/weather_api_client.dart';
import 'package:flutter_weather/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient}) : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}
