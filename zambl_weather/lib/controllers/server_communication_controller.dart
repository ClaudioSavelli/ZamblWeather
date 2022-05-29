import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zambl_weather/models/server/current_weather_response.dart';
import 'package:zambl_weather/models/server/forecast_weather_response.dart';
import '../const.dart';

class ServerCommunicationController {

  Future<Map<String, dynamic>> _getWeather(String apiUrl, String apiInfo, Map<String, dynamic> data) async {
    final uri = Uri.https(apiUrl, apiInfo, data);
    final response = await http.get(uri);
    return jsonDecode(response.body);
  }

  Future<CurrentWeatherResponse> getCurrentWeather(String city) async {
    const apiInfo = '/data/2.5/weather';
    final data = {'q': city, 'appid': API_KEY, 'units' : 'metric'};
    final map = await _getWeather(API_URL, apiInfo, data);
    return CurrentWeatherResponse.fromJson(map);
  }

  Future<ForecastWeatherResponse> getForecastWeather(String city) async {
    const apiInfo = '/data/2.5/forecast';
    final data = {'q': city, 'appid': API_KEY, 'units' : 'metric'};
    final map = await _getWeather(API_URL, apiInfo, data);
    return ForecastWeatherResponse.fromJson(map);
  }
}